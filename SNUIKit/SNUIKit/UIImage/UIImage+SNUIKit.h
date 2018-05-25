//
//  UIImage+SNUIKit.h
//  SNUIKit
//
//  Created by snlo on 2018/5/25.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SNUIKit)

/**
 获取摸个像素点的颜色值
 */
- (UIColor*)sn_getPixelColorAtLocation:(CGPoint)point;

/**
 计算图片中出现次数最多的颜色值
 */
- (UIColor*)sn_mostColor;

/**
 获取屏幕截图视图（建议不要频繁调用）
 @param frame 指定区域
 */
+ (UIImage *)sn_snapshotFrom:(CGRect)frame;

@end
