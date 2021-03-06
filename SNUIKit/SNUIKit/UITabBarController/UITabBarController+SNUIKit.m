//
//  UITabBarController+SNUIKit.m
//  snlo
//
//  Created by snlo on 2017/11/3.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UITabBarController+SNUIKit.h"

#import "UINavigationBar+SNUIKit.h"

#import "UIViewController+SNUIKit.h"

#import "SNUIKitTool.h"

@implementation UITabBarController (SNUIKit)

- (void)sn_setSeparatorLineHidden:(BOOL)hidden {
	[self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if (CGRectGetHeight(obj.bounds) < 1) {
			obj.hidden = hidden;
			*stop = YES;
		}
		[obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull objc, NSUInteger idx, BOOL * _Nonnull stopn) {
			if (CGRectGetHeight(objc.bounds) < 1) {
				objc.hidden = hidden;
				*stopn = YES;
				*stop = YES;
			}
		}];
	}];
}

- (void)sn_tabBarMoveDownOffset:(CGFloat)offset animation:(BOOL)animation {
	
	[UIView animateWithDuration:0.3 animations:^{
		
		self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + offset, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		
	} completion:^(BOOL finished) {
		
	}];
}

- (void)sn_tabBarMoveUpOffset:(CGFloat)offset animation:(BOOL)animation {
	
	[UIView animateWithDuration:0.3 animations:^{
		
		self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - offset, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		
	} completion:^(BOOL finished) {
		
	}];
}

- (void)sn_tabBarHidden:(BOOL)hidden {
	if (hidden) {
		[UIView animateWithDuration:0.3 animations:^{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, SCREEN_HEIGHT, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}];
	} else {
		[UIView animateWithDuration:0.3 animations:^{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, SCREEN_HEIGHT - [SNTool tabbarHeight], self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}];
	}
}

- (void)sn_loadViewsIfNeeded {
    for(UIViewController *viewController in  self.viewControllers){
        if ([viewController respondsToSelector:NSSelectorFromString(@"loadViewIfNeeded")]) {
            [viewController loadViewIfNeeded];
        } else {
            [viewController view];
        }
    }
}

@end
