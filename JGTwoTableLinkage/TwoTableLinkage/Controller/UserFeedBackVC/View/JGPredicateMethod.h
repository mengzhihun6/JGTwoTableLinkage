//
//  JGPredicateMethod.h
//  CommercialCarManager
//
//  Created by stkcctv on 16/8/12.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGPredicateMethod : NSObject

#pragma mark 判断邮箱，手机，QQ的格式
+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
