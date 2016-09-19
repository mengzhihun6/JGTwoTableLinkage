//
//  JGCustomSheetController.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGCustomSheetController.h"
#import "JGCustomSheetView.h"
//#import "CustomSheetView.h"

@interface JGCustomSheetController ()

@end

@implementation JGCustomSheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createShareButton];
    
    
}

- (void)createShareButton {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, kDeviceWidth - 100, 35)];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClick {
    
    NSArray *array = @[@"QQ好友",@"QQ空间",@"微信好友",@"微信朋友圈",@"微博"];
    [JGCustomSheetView showCustomSheetViewWithTitle:@"分享到" selectData:array selectImageData:array action:^(NSInteger index) {
        
        NSLog(@"----%@--",array[index]);
    }];
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
