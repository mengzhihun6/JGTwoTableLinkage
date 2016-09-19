//
//  JGCollectionViewHeaderView.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGCollectionViewHeaderView.h"

@implementation JGCollectionViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = JGRGBAColor(240, 240, 240, 0.8);
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kDeviceWidth - 80, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
    }
    return self;
}


@end
