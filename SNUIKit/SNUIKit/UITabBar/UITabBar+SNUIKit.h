//
//  UITabBar+SNUIKit.h
//  SNUIKit
//
//  Created by snlo on 2018/6/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (SNUIKit)

/**
 背景视图，在视图已经被加载完了再使用
 */
@property (nonatomic, strong) UIView * sn_overlay;

/**
 利用系统方法设置背景色，非半透明
 */
- (void)sn_systemSetBackgroundColor:(UIColor *)color;

/**
 设置背景色，通过setBackgroundImage，目前布局是安全的
 */
- (void)sn_setBackgroundColor:(UIColor *)color;

@end
