//
//  JGCalendarView.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGCalendarView.h"
#import "JGCalendarViewCell.h"

@interface JGCalendarView ()

@property (strong,nonatomic) UICollectionView *JGCollectionV;

@property (strong,nonatomic) UILabel *monthLb;

@property (strong,nonatomic) NSArray *weekDayArr;

@property (strong,nonatomic) UIView *mainV;

@end


@implementation JGCalendarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
        [self addTap];
        
        self.backgroundColor = JGRGBAColor(178, 178, 178,1.0);
    }
    return self;
}

- (void)addTap{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(next)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swiptRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pass)];
    swiptRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swiptRight];
    
}

- (void)next{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.date =[ self lastMonth:self.date];
    } completion:nil];
}

- (void)pass{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.date = [self nextMonth:self.date];
    } completion:nil];
}

- (void)initView{
    _mainV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth)];
    [self addSubview:_mainV];
    _mainV.backgroundColor = JGRGBColor(170, 170, 170);
    
    for (int i=0; i<2; i++) {
        UIButton *chooseBtn = [[UIButton alloc]init];
        [_mainV addSubview:chooseBtn];
        chooseBtn.tag = i;
        chooseBtn.backgroundColor = [UIColor clearColor];
        [chooseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [chooseBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        if (i) {
            [chooseBtn setTitle:@"下个月" forState:UIControlStateNormal];
            chooseBtn.frame = CGRectMake(10, 5, 60, kDeviceWidth/7-10);
        }else{
            [chooseBtn setTitle:@"上个月" forState:UIControlStateNormal];
            chooseBtn.frame = CGRectMake(kDeviceWidth-70, 5, 60, kDeviceWidth/7-10);
        }
    }
    _monthLb = [[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-160)/2, 10, 160, 20)];
    [_mainV addSubview:_monthLb];
    _monthLb.font = [UIFont systemFontOfSize:15];
    _monthLb.textAlignment = NSTextAlignmentCenter;
    _monthLb.textColor = [UIColor blackColor];
    _monthLb.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(kDeviceWidth/7, kDeviceWidth/7);
    layout.minimumLineSpacing = 0 ;
    layout.minimumInteritemSpacing = 0;
    
    _JGCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kDeviceWidth/7, kDeviceWidth, kDeviceWidth * 6/7) collectionViewLayout:layout];
    [_mainV addSubview:_JGCollectionV];
    _JGCollectionV.backgroundColor = [UIColor whiteColor];
    _JGCollectionV.scrollEnabled = NO;
    _JGCollectionV.delegate = self;
    _JGCollectionV.dataSource = self;
    _weekDayArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    [_JGCollectionV registerClass:[JGCalendarViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    
}
-(void)setDate:(NSDate *)date{
    _date =date;
    _monthLb.text = [NSString stringWithFormat:@"JG %li-%.2ld",[self year:date],[self month:date]];
    _monthLb.font = [UIFont systemFontOfSize:20];
    [_JGCollectionV reloadData];
}

//这个月的天数
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//第几月
- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

//年份
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

//这个月第一天是周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekDay - 1;
}
//这个月有几天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange  daysInLastMonth = [[NSCalendar currentCalendar]rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}
//上个月的时间
- (NSDate*)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate *)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
#pragma mark -CollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _weekDayArr.count;
    }else{
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JGCalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.section ==0) {
        cell.dateLb.text = _weekDayArr[indexPath.row];
        cell.dateLb.textColor = [UIColor brownColor];
    }else{
        NSInteger daysInMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        NSInteger day = 0 ;
        NSInteger i =indexPath.row;
        if (i<firstWeekday) {
            cell.dateLb.text = @"";
        }else if (i>firstWeekday+daysInMonth-1){
            cell.dateLb.text = @"";
        }else{
            day = i-firstWeekday+1;
            cell.dateLb.text = [NSString stringWithFormat:@"%li",day];
            cell.dateLb.textColor = [UIColor blackColor];
            if ([_today isEqualToDate:_date]) {
                if (day == [self day:_date]) {
                    cell.dateLb.textColor = [UIColor redColor];
                }else if (day>[self day:_date]){
                    cell.dateLb.textColor = JGRGBColor(150, 150, 150);
                }
            }else if ([_today compare:_date] == NSOrderedAscending){
                cell.dateLb.textColor = JGRGBColor(150, 150, 150);
            }
            
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekDay = [self firstWeekdayInThisMonth:_date];
    NSInteger day = 0  ;
    NSInteger i = indexPath.row;
    day = i-firstWeekDay+1;
    if (self.calendarBlock) {
        self.calendarBlock(day,[comp month],[comp year]);
    }
}

#pragma mark ==更换月份==
- (void)change:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
            [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                self.date =[ self lastMonth:self.date];
            } completion:nil];
        }
            break;
        case 1:
        {
            [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                self.date = [self nextMonth:self.date];
            } completion:nil];
        }
            break;
        default:
            break;
    }
}



@end
