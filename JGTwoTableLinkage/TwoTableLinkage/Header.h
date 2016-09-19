//
//  Header.h
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#ifndef Header_h
#define Header_h


#import "NSObject+JGProperty.h"
#import "UIImageView+WebCache.h"


//屏幕尺寸
#define kDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define kDeviceHight [[UIScreen mainScreen]bounds].size.height

#define kWindow  [[UIApplication sharedApplication].delegate window]


//颜色
#define JGGlobaBg JGRGBAColor(253, 212, 49, 1.0);
#define JGRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define JGRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JGRandomColor          JGRGBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))


#ifdef DEBUG    //调试状态打开LOG功能
#define JGLog(...) NSLog(__VA_ARGS__)
#else           //发布状态关闭LOG功能
#define JGLog(...)
#endif

#define JGLogFunc JGLog(@"%s", __func__)


#endif /* Header_h */
