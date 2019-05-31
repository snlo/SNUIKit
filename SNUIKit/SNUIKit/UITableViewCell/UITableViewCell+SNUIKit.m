//
//  UITableViewCell+SNUIKit.m
//  DoorBell
//
//  Created by snlo on 2017/8/9.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UITableViewCell+SNUIKit.h"

@implementation UITableViewCell (SNUIKit)

+ (instancetype)sn_nibCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
	NSString * identifier = NSStringFromClass([self class]);
	
	[tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
	
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

	return cell;
}

+ (instancetype)sn_cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
	NSString * identifier = NSStringFromClass([self class]);
	
	[tableView registerClass:self forCellReuseIdentifier:identifier];
	
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

	return cell;
}

#pragma mark -- public methods
- (BOOL)findFirstCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)findLastCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -- getter / setter

- (UITableView *)sn_tableView {
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

@end
