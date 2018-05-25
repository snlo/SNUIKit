//
//  UIColor+SNUIKit.m
//  SNUIKit
//
//  Created by snlo on 2018/5/25.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIColor+SNUIKit.h"

@implementation UIColor (SNUIKit)

+ (CGFloat)sn_grayColor:(UIColor *)aColor dark:(void(^)(CGFloat gray))dark light:(void(^)(CGFloat gray))light {
    CGFloat red = 0.0f;
    CGFloat green = 0.0f;
    CGFloat blue = 0.0f;
    CGFloat alpha = 0.0f;
    
    [aColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat gray = (red*30 + green*59 + blue*11) / 100;
    
    if (dark) {
        if (gray > 0.50f) {
            dark(gray);
        }
    }
    if (light) {
        if (gray <= 0.50f) {
            light(gray);
        }
    }
    if (alpha < 0.30f) {
        if (dark) {
            dark(gray);
        }
    }
    return gray;
}



@end
