//
//  JGRootViewController.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGRootViewController.h"
#import "JGTableViewController.h"
#import "JGCollectionViewController.h"
#import "JGCalendarViewController.h"
#import "JGCustomSheetController.h"
#import "JGUserFeedBackViewController.h"



@interface JGRootViewController ()

@property (nonatomic, strong)NSArray *dataArrM;

@end

@implementation JGRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _dataArrM = @[@"UITableView - UITableView联动",
                  @"UICollectionView - UITableView联动",
                  @"JGCalendarViewController - 日历",
                  @"自定义SheetView - 分享",
                  @"FeedBackVC - 用户反馈"];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"RootCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _dataArrM[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
      
        JGTableViewController *tableVC = [[JGTableViewController alloc] init];
        tableVC.title = @"两Table联动";
        [self.navigationController pushViewController:tableVC animated:YES];
    }else if(indexPath.row == 1) {
        
        JGCollectionViewController *collectionVC = [[JGCollectionViewController alloc] init];
        collectionVC.title = @"Table与Collection联动";
        [self.navigationController pushViewController:collectionVC animated:YES];
    }else if(indexPath.row == 2){
        
        JGCalendarViewController *calendarVC = [[JGCalendarViewController alloc] init];
        calendarVC.title = @"日历";
        [self.navigationController pushViewController:calendarVC animated:YES];
    }else if (indexPath.row == 3) {
        
        JGCustomSheetController *sheetVC = [[JGCustomSheetController alloc] init];
        sheetVC.title = @"自定义SheetView";
        [self.navigationController pushViewController:sheetVC animated:YES];
    }else if (indexPath.row == 4) {
        
        JGUserFeedBackViewController *feedVC = [[JGUserFeedBackViewController alloc] init];
        feedVC.title = @"意见反馈";
        [self.navigationController pushViewController:feedVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
