//
//  UIView+SNUIKit.m
//  snlo
//
//  Created by snlo on 2017/9/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UIView+SNUIKit.h"
#import <objc/runtime.h>

typedef void(^ReloadBlock)(RACSubject * commanReload);

@interface UIView ()

@property (nonatomic, strong) UIView * sn_viewFailed;
@property (nonatomic, strong) UIView * sn_viewEmpty;
@property (nonatomic, strong) UIView * sn_viewNoMoreData;

@property (nonatomic, copy) ReloadBlock reloadBlock;

@end

@implementation UIView (SNUIKit)

+ (instancetype)sn_viewWithNib {
    UIView * view = [[UIView alloc] init];
    if ([NSStringFromClass([self class]) isEqualToString:@"UIView"]) {
        return view;
    }
    view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return view;
}

- (void)setSn_showShadow:(BOOL)sn_showShadow {
    
    if (sn_showShadow) {
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        
        self.layer.shadowOpacity = 0.5f;
        
        self.layer.shadowOffset = CGSizeMake(0, 2);
        
        self.layer.shadowRadius = 8;
    }
    
    NSNumber * number = [NSNumber numberWithFloat:sn_showShadow];
    objc_setAssociatedObject(self, @selector(sn_showShadow), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSn_shadowColor:(UIColor *)sn_shadowColor {
	self.layer.shadowColor = sn_shadowColor.CGColor;
	objc_setAssociatedObject(self, @selector(sn_shadowColor), sn_shadowColor, OBJC_ASSOCIATION_COPY);
}
- (UIColor *)sn_shadowColor {
	return objc_getAssociatedObject(self, _cmd);
}

- (void)setSn_radius:(CGFloat)sn_radius {
    self.layer.cornerRadius = sn_radius;
    
    NSNumber * number = [NSNumber numberWithFloat:sn_radius];
    objc_setAssociatedObject(self, @selector(sn_radius), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sn_showShadow {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}
- (CGFloat)sn_radius {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}

#pragma mark -- 设置边框线宽度和颜色
- (void)setSn_borderWidth:(CGFloat)sn_borderWidth {
    if (sn_borderWidth > 0) {
        self.layer.borderWidth = sn_borderWidth;
        self.layer.masksToBounds = YES;
    }
    NSNumber * number = [NSNumber numberWithFloat:sn_borderWidth];
    objc_setAssociatedObject(self, @selector(sn_borderWidth), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)sn_borderWidth {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}
- (void)setSn_borderColor:(UIColor *)sn_borderColor {
    self.layer.borderColor = sn_borderColor.CGColor;
    objc_setAssociatedObject(self, @selector(sn_borderColor), sn_borderColor, OBJC_ASSOCIATION_COPY);
}
- (UIColor *)sn_borderColor {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma 旋转角度
- (void)setSn_rotationAngle:(CGFloat)sn_rotationAngle {
    self.transform = CGAffineTransformMakeRotation(M_PI * (sn_rotationAngle/360) );
    NSNumber * number = [NSNumber numberWithFloat:sn_rotationAngle];
    objc_setAssociatedObject(self, @selector(sn_rotationAngle), number, OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)sn_rotationAngle {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}

#pragma mark -- api
- (void)sn_reloadBlock:(void(^)(RACSubject * commandReload))block {
    if (block) {
        self.reloadBlock = block;
    }
}

#pragma mark -- getter or setter
- (void)setReloadBlock:(ReloadBlock)reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (ReloadBlock)reloadBlock {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -- 命中扩展
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //    if (UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero)
    //       || self.hidden
    //       || ([self isKindOfClass:UIControl.class] && !((UIControl*)self).enabled))
    //    {
    //        UIControl * control = (UIControl *)self;
    //        return [control.superview pointInside:point withEvent:event]; // original implementation
    //    }
    
    return CGRectContainsPoint(UIEdgeInsetsInsetRect(self.bounds, self.sn_hitEdgeInsets), point);
}
- (void)setSn_hitEdgeInsets:(UIEdgeInsets)sn_hitEdgeInsets {
    objc_setAssociatedObject(self, @selector(sn_hitEdgeInsets), [NSValue valueWithUIEdgeInsets:sn_hitEdgeInsets], OBJC_ASSOCIATION_RETAIN);
}
- (UIEdgeInsets)sn_hitEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, _cmd);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}
void Swizzle(Class c, SEL orig, SEL new) {
    
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}


- (UIColor *)sn_colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    CFAbsoluteTime t1 = CFAbsoluteTimeGetCurrent();
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    CFAbsoluteTime t2 = CFAbsoluteTimeGetCurrent();
    NSLog(@"create context: %.3f, render: %.3f", t1-start, t2-t1);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

@end
