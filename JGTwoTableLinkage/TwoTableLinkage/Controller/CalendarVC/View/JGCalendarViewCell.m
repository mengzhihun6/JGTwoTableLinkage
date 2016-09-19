//
//  JGCalendarViewCell.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGCalendarViewCell.h"

@implementation JGCalendarViewCell

- (UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc]initWithFrame:self.bounds];
        _dateLb.textAlignment = NSTextAlignmentCenter;
        _dateLb.font = [UIFont systemFontOfSize:17];
        [self addSubview:_dateLb];
    }
    return _dateLb;
}

@end
