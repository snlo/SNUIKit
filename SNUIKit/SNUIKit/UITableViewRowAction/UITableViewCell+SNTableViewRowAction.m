//
//  UITableViewCell+SNTableViewRowAction.m
//  tableView
//
//  Created by snlo on 10/23/15.
//  Copyright © 2015 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UITableViewRowAction+SNTableViewRowAction.h"

@implementation UITableViewCell (SNTableViewRowAction)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method willTransitionToState = class_getInstanceMethod(self, @selector(willTransitionToState:));
        Method __willTransitionToState = class_getInstanceMethod(self, @selector(__willTransitionToState:));
        method_exchangeImplementations(willTransitionToState, __willTransitionToState);
        
        Method titleForDeleteConfirmationButton = class_getInstanceMethod([UITableView class], NSSelectorFromString(@"_titleForDeleteConfirmationButtonForRowAtIndexPath:"));
        Method _titleForDeleteConfirmationButton = class_getInstanceMethod([UITableView class], NSSelectorFromString(@"titleForDeleteConfirmationButtonForRowAtIndexPath:"));
        method_exchangeImplementations(titleForDeleteConfirmationButton, _titleForDeleteConfirmationButton);
    });
}

- (void)__willTransitionToState:(UITableViewCellStateMask)state {
    
    [self __willTransitionToState:state];

    if (state == UITableViewCellStateShowingDeleteConfirmationMask) {
        
        UITableView *tableView = [self valueForKey:@"_tableView"];
        if (![tableView.delegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
            return;
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            UIView *swipeToDeleteConfirmationView = [self valueForKey:@"_swipeToDeleteConfirmationView"];
            if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
                for (UIButton *deleteButton in swipeToDeleteConfirmationView.subviews) {
                    
                    UITableViewRowAction *rowAction = [deleteButton valueForKey:@"_action"];
                    if (rowAction.backgroundColor) {
                        deleteButton.backgroundColor = rowAction.backgroundColor;
                    }
                    
                    deleteButton.enabled = rowAction.sn_enabled;

                    if (rowAction.sn_image) {
                        NSTextAttachment *imageAtt = [[NSTextAttachment alloc] init];
                        imageAtt.image = rowAction.sn_image;
                        [deleteButton setAttributedTitle:[NSAttributedString attributedStringWithAttachment:imageAtt] forState:UIControlStateNormal];
                    }
                }
                return;
            }
            
            NSIndexPath *indexPath = [tableView indexPathForCell:self];
            
            NSArray *rowActions = [tableView.delegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
            self.rowActions = rowActions;
            
            UIButton *deleteConfirmButton = swipeToDeleteConfirmationView.subviews.firstObject;
            deleteConfirmButton.titleLabel.textColor = deleteConfirmButton.backgroundColor;
            CGFloat buttonWidth = deleteConfirmButton.bounds.size.width / rowActions.count;
            CGFloat buttonHeight = deleteConfirmButton.bounds.size.height;
            for (NSInteger index = 0; index < rowActions.count; index++) {
                
                UITableViewRowAction *rowAction = rowActions[index];
                
                [rowAction setValue:indexPath forKey:@"indexPath"];
                
                UIButton *rowActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
                if (rowAction.backgroundColor) {
                    rowActionButton.backgroundColor = rowAction.backgroundColor;
                } else {
                    rowActionButton.backgroundColor = rowAction.style == UITableViewRowActionStyleDestructive ? deleteConfirmButton.backgroundColor : [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:193.0/255.0 alpha:1.0];
                }
                
                if (rowAction.sn_enabled) {
                    [rowActionButton addTarget:rowAction action:NSSelectorFromString(@"actionTriggered:") forControlEvents:UIControlEventTouchUpInside];
                }
                
                rowActionButton.frame = CGRectMake((rowActions.count - 1 - index) * buttonWidth, 0, buttonWidth, buttonHeight);
                
                rowAction.sn_image ? [rowActionButton setImage:rowAction.sn_image forState:UIControlStateNormal]
                                : [rowActionButton setTitle:rowAction.title forState:UIControlStateNormal];
                
                [deleteConfirmButton addSubview:rowActionButton];
            }
        });
    }
}

- (void)setRowActions:(NSArray *)rowActions {
    objc_setAssociatedObject(self, @selector(rowActions), rowActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)rowActions {
    return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation UITableView (SNTableViewRowAction)

- (id)titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.delegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    // System version above iOS7 will not go on.
    NSArray *rowActions = [self.delegate tableView:self editActionsForRowAtIndexPath:indexPath];
    NSMutableString *placeholder = [NSMutableString string];
    NSString *longestString = @"   "; //A placeholder string for the default width.
    {
        CGFloat fontSize = 12;
        for (UITableViewRowAction *action in rowActions) {
            CGFloat actionTitleWidth = [action.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
//            CGFloat actionTitleWidth = [action.title sizeWithFont:[UIFont systemFontOfSize:fontSize]].width;
            CGFloat currentLongestStringWidth = [longestString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;;
            if (actionTitleWidth > currentLongestStringWidth) {
                longestString = action.title;
            }
        }
    }
    for (int index = 0; index < rowActions.count; index++) {
        [placeholder appendString:longestString];
    }
    return placeholder;
}

@end
