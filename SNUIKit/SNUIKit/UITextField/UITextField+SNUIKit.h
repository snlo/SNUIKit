//
//  UITextField+SNUIKit.h
//  snlo
//
//  Created by snlo on 2017/12/9.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SNUIKit)

/**
 禁止复制
 */
@property (nonatomic, assign) IBInspectable BOOL sn_isMenuInVisible;

/**
 禁止表情输入
 */
@property (nonatomic, assign) IBInspectable BOOL sn_isForbidEmoji;

@end
