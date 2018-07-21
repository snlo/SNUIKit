//
//  UITabBar+SNUIKit.m
//  SNUIKit
//
//  Created by snlo on 2018/6/30.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UITabBar+SNUIKit.h"

#import <objc/runtime.h>
#import <ReactiveObjC.h>

#import "SNUIKitTool.h"

@implementation UITabBar (SNUIKit)

- (UIView *)sn_overlay {
    UIView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[UIView alloc] init];
        
        self.shadowImage = [UIImage new];
        [self setBackgroundImage:[UIImage new]];
        UIView * viewBackground = [UIView new];
        
        //        if (@available(iOS 11.0, *)) {
        viewBackground = self.subviews.firstObject;
        //        } else {
        //            viewBackground = [self valueForKey:@"_backgroundView"];
        //        }
        
        [viewBackground addSubview:view];
        //        viewBackground.layer.masksToBounds = YES;
        
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        // 设置subView相对于VIEW的上左下右各40像素
        NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:viewBackground attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:viewBackground attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        // 由于iOS坐标系的原点在左上角，所以设置右边距使用负值
        NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:viewBackground attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:viewBackground attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        // 将四条约束加进数组中
        NSArray *array = [NSArray arrayWithObjects:constraint1, constraint2, constraint3, constraint4 ,nil];
        // 把约束条件设置到父视图的Contraints中
        [viewBackground addConstraints:array];
        
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return view;
}
- (void)setSn_overlay:(UIView *)sn_overlay {
    objc_setAssociatedObject(self, @selector(sn_overlay), sn_overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sn_systemSetBackgroundColor:(UIColor *)color {
//    self.translucent = NO;
    self.barTintColor = color;
}

- (void)sn_setBackgroundColor:(UIColor *)color {
    [self setBackgroundImage:[SNTool imageWithColor:color size:self.frame.size]];
}

@end
