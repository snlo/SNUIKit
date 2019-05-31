//
//  UITableViewHeaderFooterView+SNUIKit.m
//  snlo
//
//  Created by snlo on 2017/12/13.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UITableViewHeaderFooterView+SNUIKit.h"

#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (SNUIKit)

+ (instancetype)sn_nibHeaderFooterViewWithTableView:(UITableView *)tableView section:(NSUInteger)section {
    
    NSString * identifier = NSStringFromClass([self class]);
    
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
    
    UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    return view;
}

+ (instancetype)sn_headerFooterViewWithTableView:(UITableView *)tableView section:(NSUInteger)section {
    
    NSString * identifier = NSStringFromClass([self class]);
    
    [tableView registerClass:self forHeaderFooterViewReuseIdentifier:identifier];
    
    UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    return view;
}

@end
