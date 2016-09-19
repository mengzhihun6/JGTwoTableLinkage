//
//  JGCustomSheetView.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGCustomSheetView.h"
#import "JGCustomSheetCell.h"

#define AnimateDuration 0.3

@implementation JGCustomSheetView

JGCustomSheetView *JGbg_View = nil;

UICollectionView *JGCollection_View =nil;
UIView *JGContent_View = nil;
CGFloat JGContent_ViewHeight = 0;
@synthesize selectData,selectImageData;

+(void)showCustomSheetViewWithTitle:(NSString*)title selectData:(NSArray<NSString*>*)selectData selectImageData:(NSArray<NSString*>*)selectImageData action:(void(^)(NSInteger index))action
{
    
    JGbg_View = [[JGCustomSheetView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JGbg_View.backgroundColor = [UIColor blackColor];
    JGbg_View.alpha = 0.4;
    [kWindow addSubview:JGbg_View];
    JGbg_View.action = action;
    JGbg_View.selectImageData = selectImageData;
    JGbg_View.selectData =selectData;
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [JGbg_View addGestureRecognizer:tap];
    
    JGContent_ViewHeight = kDeviceHight*(1.f/3.f);
    JGContent_View = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHight, kDeviceWidth, JGContent_ViewHeight)];
    JGContent_View.backgroundColor = [UIColor whiteColor];
    [kWindow addSubview:JGContent_View];
    CGFloat titleLabelHeight = 50;
    
    UIButton*button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 5, titleLabelHeight-10, titleLabelHeight-10);
    [button setBackgroundImage:[UIImage imageNamed:@"cancelButton"] forState:0];
    [button addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    [JGContent_View addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.bounds =CGRectMake(0, 0, kDeviceWidth-CGRectGetWidth(button.frame)*2, titleLabelHeight);
    titleLabel.center = CGPointMake(kDeviceWidth/2, titleLabelHeight/2);
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    [JGContent_View addSubview:titleLabel];
    
    UIView*line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxX(button.frame), kDeviceWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [JGContent_View addSubview:line];
    
    CGFloat JGCollection_ViewHeight = JGContent_ViewHeight - titleLabelHeight;
    CGFloat cellHeight = JGCollection_ViewHeight*(1.f/2.f);
    
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(cellHeight, cellHeight+30);
    layout.minimumLineSpacing = 10;//设置每个item之间的间距
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    JGCollection_View = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxX(button.frame)+1, kDeviceWidth, JGCollection_ViewHeight) collectionViewLayout:layout];
    JGCollection_View.delegate = (id<UICollectionViewDelegate>)JGbg_View;
    JGCollection_View.dataSource = (id<UICollectionViewDataSource>)JGbg_View;
    JGCollection_View.showsVerticalScrollIndicator = 0;
    JGCollection_View.showsHorizontalScrollIndicator = 0;
    JGCollection_View.backgroundColor = [UIColor whiteColor];
    [JGContent_View addSubview:JGCollection_View];
    
    [JGCollection_View registerNib:[UINib nibWithNibName:@"JGCustomSheetCell" bundle:nil] forCellWithReuseIdentifier:@"JGCustomSheetCell"];
    
    [JGCustomSheetView show];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return JGbg_View.selectData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JGCustomSheetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JGCustomSheetCell" forIndexPath:indexPath];
    
    if (JGbg_View.selectData!=nil) {
        cell.title_Label.text = JGbg_View.selectData[indexPath.row];
    }
    if (JGbg_View.selectImageData!=nil) {
        cell.image_View.image = [UIImage imageNamed:selectImageData[indexPath.row]];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (JGbg_View.action) {
        JGbg_View.action(indexPath.row);
    }
    [JGCustomSheetView hidden];
}

+(void)show
{
    [UIView animateWithDuration:AnimateDuration animations:^{
        JGContent_View.frame = CGRectMake(0, kDeviceHight-JGContent_ViewHeight, kDeviceWidth, JGContent_ViewHeight);
    } completion:^(BOOL finished) {
        
    }];
}
+(void)hidden
{
    [UIView animateWithDuration:AnimateDuration animations:^{
        JGContent_View.frame = CGRectMake(0, kDeviceHight, kDeviceWidth, JGContent_ViewHeight);
    } completion:^(BOOL finished) {
        [JGbg_View removeFromSuperview];
        [JGContent_View removeFromSuperview];
        JGbg_View=nil;
        JGContent_View=nil;
    }];
}

@end
