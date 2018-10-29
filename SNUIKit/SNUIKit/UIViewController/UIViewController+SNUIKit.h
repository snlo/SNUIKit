//
//  UIViewController+SNUIKit.h
//  snlo
//
//  Created by snlo on 2017/9/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (SNUIKit)


/**
 有效边缘返回手势，设置为NO则禁止边缘返回，主要用于阻止无效的返回，只能在viewwillapper中实现
 */
@property (nonatomic, assign) BOOL sn_isAbleEdgeGesture;


/**
 pop 到制定控制器
 
 @param viewControllerName 目标viewcontroller的名字
 @param selectedIndex 如果是在tabbarviewcontroller中,期望的selected,无期望则为 -1或小于0
 @param animated 如果为 ‘NO’ 则没有转场动画
 */
- (void)sn_popToViewControllerWithName:(NSString *)viewControllerName estimatedTabBarSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

/**
 附加参数，可随中间件携带
 */
@property (nonatomic, strong) NSMutableDictionary * sn_params;

/**
 动态设置状态栏的风格，记得在info.plist中设置‘View controller-based status bar appearance’为‘NO’
 */
- (void)sn_autoStatusBarStyle __attribute__((deprecated("Have been abolished.")));

@end
