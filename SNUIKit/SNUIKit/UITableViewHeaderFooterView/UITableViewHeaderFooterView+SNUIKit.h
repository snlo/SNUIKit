//
//  UITableViewHeaderFooterView+SNUIKit.h
//  snlo
//
//  Created by snlo on 2017/12/13.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (SNUIKit)

/**
 加载xib创建的headerFooterView
 */
+ (instancetype)sn_nibHeaderFooterViewWithTableView:(UITableView *)tableView section:(NSUInteger)section;

/**
 加载非xib创建的headerFooterView
 */
+ (instancetype)sn_headerFooterViewWithTableView:(UITableView *)tableView section:(NSUInteger)section;

@end
