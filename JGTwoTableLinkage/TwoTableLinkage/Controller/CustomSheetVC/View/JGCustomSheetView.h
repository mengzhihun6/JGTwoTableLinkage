//
//  JGCustomSheetView.h
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGCustomSheetView : UIView

@property (nonatomic,copy) NSArray *selectData;
@property (nonatomic,copy) void(^action)(NSInteger index);
@property (nonatomic,copy) NSArray * selectImageData;

+(void)showCustomSheetViewWithTitle:(NSString*)title selectData:(NSArray<NSString*>*)selectData selectImageData:(NSArray<NSString*>*)selectImageData action:(void(^)(NSInteger index))action;



@end
