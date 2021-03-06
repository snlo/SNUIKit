//
//  UITableViewCell+SNUIKit.h
//  DoorBell
//
//  Created by snlo on 2017/8/9.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (SNUIKit)

/**
 加载xib创建的cell
 */
+ (instancetype)sn_nibCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 加载非xib创建的cell
 */
+ (instancetype)sn_cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 自己的tableview
 */
- (UITableView *)sn_tableView;


@end
