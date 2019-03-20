//
//  UIViewController+SNUIKit.m
//  snlo
//
//  Created by snlo on 2017/9/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UIViewController+SNUIKit.h"

#import <objc/runtime.h>
#import <Aspects/Aspects.h>

#import "SNUIKitTool.h"

#import "UINavigationBar+SNUIKit.h"
#import "UIColor+SNUIKit.h"
#import "UIImage+SNUIKit.h"

@interface UIViewController () <UIGestureRecognizerDelegate>

/**
 是否隐藏导航栏背景，默认为NO
 */
@property (nonatomic, assign) BOOL sn_isNavigationBarHidden;

/**
 是否执行navigationBar进场的渐变动画
 */
@property (nonatomic, assign) BOOL sn_animationNavigationBarComeBack;

@end

@implementation UIViewController (SNUIKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SNUIKitTool_replaceMethodFromNew(self, @selector(viewWillAppear:), @selector(SNUIKit_viewWillAppear:));
    });
}

- (void)SNUIKit_viewWillAppear:(BOOL)animated {
    if ([NSStringFromClass(self.class) hasPrefix:@"UI"] ||
        [NSStringFromClass(self.class) hasPrefix:@"_UI"] ) {
        return;
    }
	if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		self.navigationController.interactivePopGestureRecognizer.delegate = self;
	}
	
	if ([self snuikit_navigationController].viewControllers.count < 2) {
		self.sn_isAbleEdgeGesture = @(NO);
	}
    [self SNUIKit_viewWillAppear:animated];
}

//解决多次触发navigation边缘返回手势后的冲突
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	return [self.sn_isAbleEdgeGesture boolValue]; //    <UIGestureRecognizerDelegate>
}

#pragma clang diagnostic pop

#pragma mark -- event response

#pragma mark -- getter or setter

- (UINavigationController *)snuikit_navigationController {
    if (self.navigationController) {
        return self.navigationController;
    } else if (self.tabBarController.navigationController) {
        return self.tabBarController.navigationController;
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)self;
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        if (((UITabBarController *)self).navigationController) {
            return ((UITabBarController *)self).navigationController;
        } else {
            return [UINavigationController new];
        }
    } else {
        return [UINavigationController new];
    }
}


- (void)setSn_isAbleEdgeGesture:(NSNumber *)sn_isAbleEdgeGesture {
    objc_setAssociatedObject(self, @selector(sn_isAbleEdgeGesture), sn_isAbleEdgeGesture, OBJC_ASSOCIATION_RETAIN);
}
- (NSNumber *)sn_isAbleEdgeGesture {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    if (!number) {
        number = [NSNumber numberWithBool:YES];
        objc_setAssociatedObject(self, @selector(sn_isAbleEdgeGesture), number, OBJC_ASSOCIATION_RETAIN);
    }
    return number;
}


- (void)setSn_params:(NSMutableDictionary *)sn_params {
    objc_setAssociatedObject(self, @selector(sn_params), sn_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableDictionary *)sn_params {
    NSMutableDictionary * tempDictionary = objc_getAssociatedObject(self, _cmd);
    if (!tempDictionary) {
        tempDictionary = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(sn_params), tempDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return tempDictionary;
}

#pragma mark -- API

- (void)sn_popToViewControllerWithName:(NSString *)viewControllerName estimatedTabBarSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
{
	UINavigationController * tempController;
	BOOL __block _isErrorSign = false;
	UIViewController * shouldViewController = [[NSClassFromString(viewControllerName) alloc] init];
	
	if (self.tabBarController) {
		tempController = self.tabBarController.navigationController;
	} else if (self.navigationController) {
		tempController = self.navigationController;
	} else {
		if (self.presentingViewController) {
			[self dismissViewControllerAnimated:animated completion:^{
				[[SNTool topViewController] sn_popToViewControllerWithName:viewControllerName estimatedTabBarSelectedIndex:selectedIndex animated:animated];
			}];
		} else {
			[tempController pushViewController:shouldViewController animated:animated];
		}
	}
	NSLog(@"viewControllers -- %@",tempController.viewControllers);
	
	for (UIViewController * obj in tempController.viewControllers) {
		_isErrorSign = YES;
		if ([obj isKindOfClass:[shouldViewController class]]) {
			[tempController popToViewController:obj animated:animated];
			_isErrorSign = NO;
			break;
		}
	}
	
	if (_isErrorSign) {
		[tempController popToRootViewControllerAnimated:animated];
		
		if ([tempController.viewControllers.lastObject isKindOfClass:[UITabBarController class]]) {
			UITabBarController * tabBarController = tempController.viewControllers.lastObject;
			
			NSLog(@"tabBarController -- %@",tabBarController.viewControllers);
			
			for (int i = 0; i < tabBarController.viewControllers.count; i ++) {
				_isErrorSign = YES;
				if ([tabBarController.viewControllers[i] isKindOfClass:[shouldViewController class]]) {
					tabBarController.selectedIndex = i;
					_isErrorSign = NO;
					break;
				}
			}
			if (selectedIndex >= 0) {
				tabBarController.selectedIndex = selectedIndex;
			}
			
		} else {
			[self dismissViewControllerAnimated:animated completion:^{
				[[SNTool topViewController] sn_popToViewControllerWithName:viewControllerName estimatedTabBarSelectedIndex:selectedIndex animated:animated];
			}];
		}
		if (_isErrorSign) {
			
			if (self.presentingViewController) {
				[self dismissViewControllerAnimated:animated completion:^{
					[[SNTool topViewController] sn_popToViewControllerWithName:viewControllerName estimatedTabBarSelectedIndex:selectedIndex animated:animated];
				}];
			} else {
				if ([SNTool topViewController].navigationController) {
					[[SNTool topViewController].navigationController pushViewController:shouldViewController animated:animated];
				} else {
					[[SNTool topViewController] presentViewController:shouldViewController animated:animated completion:^{
						
					}];
				}
			}
			NSLog(@"%@ is not within the scope of pop",viewControllerName);
		}
	}
}

- (void)sn_autoStatusBarStyle {
    return;
	dispatch_async(dispatch_get_main_queue(), ^{
		UIView * view = self.view;
		__block NSMutableArray * viewArray = [NSMutableArray array];
		[self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			if (obj.frame.origin.x >= 0 && obj.frame.origin.x <= SCREEN_WIDTH/2) {
				if (obj.frame.origin.y >= 0 && obj.frame.origin.y <= kStatusBarAndNavigationBarHeight - 44) {
					if (obj.frame.size.width > SCREEN_WIDTH/2 && obj.frame.size.height >= 20) {
						[viewArray addObject:obj];
					}
				}
			}
		}];
		view = viewArray.lastObject;
		CGSize size = CGSizeMake(SCREEN_WIDTH, [UIApplication sharedApplication].statusBarFrame.size.height);
		UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
		CGContextRef context = UIGraphicsGetCurrentContext();
		[view.layer renderInContext:context];
		UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		[UIColor sn_grayColor:[image sn_mostColor] dark:^(CGFloat gray) {
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
		} light:^(CGFloat gray) {
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
		}];
	});
}

@end
