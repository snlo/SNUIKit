//
//  UIColor+SNUIKit.h
//  SNUIKit
//
//  Created by snlo on 2018/5/25.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SNUIKit)

/**
 灰度值查询

 @param aColor 颜色
 @param dark 暗回调
 @param light 明回调
 */
+ (CGFloat)sn_grayColor:(UIColor *)aColor dark:(void(^)(CGFloat gray))dark light:(void(^)(CGFloat gray))light;

@end
