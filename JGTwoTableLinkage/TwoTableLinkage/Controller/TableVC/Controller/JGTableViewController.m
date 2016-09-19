//
//  JGTableViewController.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGTableViewController.h"
#import "JGCategoryModel.h"
#import "JGLeftTableViewCell.h"
#import "JGRightTableViewCell.h"
#import "JGTableViewHeaderView.h"


static NSString * const JGLeftCellID = @"JGLeftCellID";
static NSString * const JGRightCellID = @"JGRightCellID";


@interface JGTableViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic, strong) NSMutableArray *LeftDataArrM;
@property (nonatomic, strong) NSMutableArray *RightDataArrM;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@end

@implementation JGTableViewController

#pragma mark - 懒加载数据源数组 -
- (NSMutableArray *)LeftDataArrM {
    if (!_LeftDataArrM) {
        _LeftDataArrM = [NSMutableArray array];
    }
    return _LeftDataArrM;
}

- (NSMutableArray *)RightDataArrM {
    if (!_RightDataArrM) {
        _RightDataArrM = [NSMutableArray array];
    }
    return _RightDataArrM;
}

- (UITableView *)leftTableView {
    
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, kDeviceHight)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[JGLeftTableViewCell class] forCellReuseIdentifier:JGLeftCellID];
    }
    
    return _leftTableView;
}

- (UITableView *)rightTableView {
    
    if (!_rightTableView) {
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 64, kDeviceWidth - 80, kDeviceHight)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.tableFooterView = [UIView new];
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[JGRightTableViewCell class] forCellReuseIdentifier:JGRightCellID];
    }
    
    return _rightTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _selectIndex = 0;
    _isScrollDown = YES;
    
    //加载数据
    [self loadData];
    
    //创建表格
    [self createTable];
    
    
}

- (void)loadData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods = dict[@"data"][@"food_spu_tags"];
    for (NSDictionary *dict in foods) {
//        JGLog(@"======  %@",dict);
        JGCategoryModel *model = [JGCategoryModel objectWithDictionary:dict];
        
        [self.LeftDataArrM addObject:model];
        
        NSMutableArray *datas = [NSMutableArray array];
        
        for (JGFoodModel *f_model in  model.spus) {
            
            [datas addObject:f_model];
        }
        
        [self.RightDataArrM addObject:datas];
    }

}

#pragma mark - 创建表格 -
- (void)createTable {
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


#pragma mark - UITableViewDataSourse -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return (_leftTableView == tableView) ? 1 : self.LeftDataArrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (_leftTableView == tableView) ? self.LeftDataArrM.count : [self.RightDataArrM[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_leftTableView == tableView) {
        
        JGLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGLeftCellID forIndexPath:indexPath];
        JGFoodModel *model = self.LeftDataArrM[indexPath.row];
        cell.name.text = model.name;
        
        return cell;
    }else {
        
        JGRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGRightCellID forIndexPath:indexPath];
        JGFoodModel *model = self.RightDataArrM[indexPath.section][indexPath.row];
        cell.model = model;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (_rightTableView == tableView) ? 20 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    JGTableViewHeaderView *view = [[JGTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    JGFoodModel *model = self.LeftDataArrM[section];
    view.name.text = model.name;
    
    return  (_rightTableView == tableView) ? view : nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && _rightTableView.dragging) {
        [self selectRowAtIndexPath:section];
    }
    
    
    
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && _rightTableView.dragging)
    {
        [self selectRowAtIndexPath:section + 1];
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_leftTableView != tableView) return;
    
    _selectIndex = indexPath.row;
    [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index {
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    static CGFloat lastOffsetY = 0;
    UITableView *tableView = (UITableView *)scrollView;
    if (_rightTableView == tableView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
