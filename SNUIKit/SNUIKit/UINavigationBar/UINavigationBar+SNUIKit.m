//
//  UINavigationBar+SNUIKit.m
//  WisView
//
//  Created by snlo on 2017/4/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UINavigationBar+SNUIKit.h"

#import <objc/runtime.h>
#import <ReactiveObjC.h>

#import "UIColor+SNUIKit.h"

#import "SNUIKitTool.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface UINavigationBar ()

@property (nonatomic, strong) NSNumber * sn_height;

@end

@implementation UINavigationBar (SNUIKit)

- (UIView *)sn_overlay {
    UIView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[UIView alloc] init];
        
        if (@available(iOS 11.0, *)) { //判断系统版本针对变动的视图层级
            self.sn_leftTitle.frame = CGRectMake(20, 0, self.frame.size.width/2, self.frame.size.height);
            [self addSubview:self.sn_leftTitle];
            [RACObserve(view, backgroundColor) subscribeNext:^(id  _Nullable x) {
                if (!self.hidden) {
                    
                }
                [self setBarTintColor:x];
            }];
        } else {
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.shadowImage = [UIImage new];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            self.sn_leftTitle.frame = CGRectMake(20, [UIApplication sharedApplication].statusBarFrame.size.height, self.frame.size.width/2, self.frame.size.height);
            [view addSubview:self.sn_leftTitle];
        }
        
        UIView * parentView = self.subviews.firstObject;
        [parentView addSubview:view];
        parentView.layer.masksToBounds = YES;
        // 设置subView相对于VIEW的上左下右各40像素
        NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        // 由于iOS坐标系的原点在左上角，所以设置右边距使用负值
        NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        // 将四条约束加进数组中
        NSArray *array = [NSArray arrayWithObjects:constraint1, constraint2, constraint3, constraint4 ,nil];
        // 把约束条件设置到父视图的Contraints中
        [parentView addConstraints:array];
        
        [RACObserve(self.sn_leftTitle, text) subscribeNext:^(NSString *  _Nullable x) {
            if (x.length > 0) {
                self.sn_leftTitle.hidden = NO;
                self.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor clearColor]};
                [self sn_setLargeTitlesPerfers:NO LargeTitleTextAttributes:nil];
            } else {
                [self sn_setLargeTitlesPerfers:YES LargeTitleTextAttributes:nil];
            }
        }];
        [RACObserve(view, backgroundColor) subscribeNext:^(id  _Nullable x) {
            //动态 statusBarStyle
            if (!self.hidden) {
                [UIColor sn_grayColor:x dark:^(CGFloat gray) {
                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                } light:^(CGFloat gray) {
                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                }];
            }
        }];
        
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return view;
}
- (void)setSn_overlay:(UIView *)sn_overlay {
    objc_setAssociatedObject(self, @selector(sn_overlay), sn_overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSn_leftTitle:(UILabel *)sn_leftTitle {
    objc_setAssociatedObject(self, @selector(sn_leftTitle), sn_leftTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)sn_leftTitle {
    UILabel * label = objc_getAssociatedObject(self, _cmd);
    if (!label) {
        label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.hidden = YES;
        label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        objc_setAssociatedObject(self, _cmd, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return label;
}

- (void)sn_setBackgroundColor:(UIColor *)backgroundColor {
    self.sn_overlay.backgroundColor = backgroundColor;
}

- (void)sn_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)sn_setElementsAlpha:(CGFloat)alpha {
    
    BOOL isHave = NO;
    unsigned int count;
    Ivar *ivars =  class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * cName =  ivar_getName(ivar);
        NSString *ocName = [NSString stringWithUTF8String:cName];
        if ([ocName isEqualToString:@"_leftViews"]) {
            isHave = YES;
        }
    }
    free(ivars);
    if (!isHave) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![NSStringFromClass([obj class]) isEqualToString:@"_UIBarBackground"]) {
                [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull objj, NSUInteger idxx, BOOL * _Nonnull stopp) {
                    objj.alpha = alpha;
                }];
            }
        }];
        return;
    }
    
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)sn_setLargeTitlesPerfers:(BOOL)perfers LargeTitleTextAttributes:(NSDictionary<NSAttributedStringKey, id> *)attributes {
    if (@available(iOS 11.0, *)) {
        self.prefersLargeTitles = perfers;
        if (attributes.count > 0) {
            [self setLargeTitleTextAttributes:attributes];
        }
    } else {
        
    }
}


@end
