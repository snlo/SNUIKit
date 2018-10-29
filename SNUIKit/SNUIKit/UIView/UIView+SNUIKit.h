//
//  UIView+SNUIKit.h
//  snlo
//
//  Created by snlo on 2017/9/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSubject;

@interface UIView (SNUIKit)

/**
 加载XIB文件
 */
+ (instancetype)sn_viewWithNib;

/**
 显示阴影，默认为NO
 */
@property (nonatomic, assign) IBInspectable BOOL sn_showShadow;

/**
 阴影颜色
 */
@property (nonatomic, copy) IBInspectable UIColor * sn_shadowColor;

/**
 添加圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat sn_radius;

/**
 设置边框线宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat sn_borderWidth;

/**
 设置边框线颜色
 */
@property (nonatomic, copy) IBInspectable UIColor * sn_borderColor;

/**
 旋转角度
 */
@property (nonatomic, assign) IBInspectable CGFloat sn_rotationAngle;



/**
 重新加载
 */
- (void)sn_reloadBlock:(void(^)(RACSubject * commandReload))block;

/**
 空载视图，需自定义在分类中
 */
@property (nonatomic, readonly) UIView * sn_viewEmpty;

/**
 失败视图，需自定义在分类中
 */
@property (nonatomic, readonly) UIView * sn_viewFailed;

/**
 tableview的空数据视图，需自定义在分类中
 */
@property (nonatomic, readonly) UIView * sn_viewNoMoreData;

/**
 加载等待视图，需自定义在分类中
 */
@property (nonatomic, readonly) UIView * sn_viewLoading;

/**
 命中边缘，负数为扩大
 */
@property(nonatomic) UIEdgeInsets sn_hitEdgeInsets;

/**
 获取某个点的颜色
 */
- (UIColor *)sn_colorOfPoint:(CGPoint)point;

/**
 在视图层级中返回最顶层的视图控制器
 */
- (UIViewController *)topMostViewController;

@end
