//
//  JGCalendarViewController.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGCalendarViewController.h"
#import "JGCalendarView.h"


@interface JGCalendarViewController ()

@end

@implementation JGCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createCalendarView];
    
}

- (void)createCalendarView {
    
    JGCalendarView *calendarPicker = [[JGCalendarView alloc] initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceWidth - 64)];
    [self.view addSubview:calendarPicker];
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    calendarPicker.calendarBlock = ^(NSInteger day,NSInteger month,NSInteger year){
      
        JGLog(@" === %ld - %ld - %ld",(long)day, month, year);
        
    };
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
