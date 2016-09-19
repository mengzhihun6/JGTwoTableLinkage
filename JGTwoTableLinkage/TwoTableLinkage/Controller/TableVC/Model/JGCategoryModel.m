//
//  JGCategoryModel.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGCategoryModel.h"

@implementation JGCategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"spus": @"JGFoodModel" };
}


@end


@implementation JGFoodModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{ @"foodId": @"id" };
}

@end
