//
//  UINavigationBar+SNUIKit.h
//  WisView
//
//  Created by snlo on 2017/4/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (SNUIKit)

/**
 背景视图
 */
@property (nonatomic, strong) UIView * sn_overlay;

/**
 左标题
 */
@property (nonatomic, strong) UILabel * sn_leftTitle;

/**
 设置背景颜色
 */
- (void)sn_setBackgroundColor:(UIColor *)backgroundColor;

/**
 设置透明度
 */
- (void)sn_setElementsAlpha:(CGFloat)alpha;

/**
 设置y轴位置
 */
- (void)sn_setTranslationY:(CGFloat)translationY;

/**
 设置大标题
 */
- (void)sn_setLargeTitlesPerfers:(BOOL)perfers LargeTitleTextAttributes:(NSDictionary<NSAttributedStringKey, id> *)attributes;

@end
