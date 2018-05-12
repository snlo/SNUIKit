//
//  SNUIKitTool.m
//  SNUIKit
//
//  Created by sunDong on 2018/5/7.
//  Copyright © 2018年 snloveydus. All rights reserved.
//

#import "SNUIKitTool.h"

#import <objc/runtime.h>

#import "UIViewController+SNViewController.h"

#import "SNUIKitTool.h"

singletonImplemention(SNUIKitTool)

#pragma mark -- height

#pragma mark -- getter // setter

- (UIColor *)blackColor {
	if (!_blackColor) {
		_blackColor = [UIColor blackColor];
	} return _blackColor;
}
- (UIColor *)contentColor {
	if (!_contentColor) {
		_contentColor = [UIColor grayColor];
	} return _contentColor;
}
- (UIColor *)hintColor {
    if (!_hintColor) {
        _hintColor = [UIColor redColor];
    } return _hintColor;
}
- (UIColor *)mainColor {
    if (!_mainColor) {
        _mainColor = [UIColor blackColor];
    } return _mainColor;
}
- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor grayColor];
    } return _separatorColor;
}

@end
