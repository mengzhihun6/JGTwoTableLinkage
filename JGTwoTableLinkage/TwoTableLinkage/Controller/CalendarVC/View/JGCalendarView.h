//
//  JGCalendarView.h
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JGCalendarBlock)(NSInteger day,NSInteger month,NSInteger year);

@interface JGCalendarView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) NSDate *date;

@property (strong,nonatomic) NSDate *today;

@property (strong,nonatomic) JGCalendarBlock calendarBlock;

@end
