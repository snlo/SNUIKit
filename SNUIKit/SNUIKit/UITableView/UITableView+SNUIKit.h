//
//  UITableView+SNUIKit.h
//  snlo
//
//  Created by snlo on 2017/11/10.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SNUIKit)

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray * sn_dataSource;

/**
 设置动态 scrollEnabled 属性
 */
- (void)sn_setAutoScrollEnabled;

@end
