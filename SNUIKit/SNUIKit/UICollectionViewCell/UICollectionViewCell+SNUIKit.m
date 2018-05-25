//
//  UICollectionViewCell+SNUIKit.m
//  snlo
//
//  Created by snlo on 2017/9/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UICollectionViewCell+SNUIKit.h"

@implementation UICollectionViewCell (SNUIKit)

+ (instancetype)sn_nibCellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
	NSString * identifier = NSStringFromClass([self class]);

	[collectionView registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier];
	
	UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

	return cell;
}

+ (instancetype)sn_cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
	NSString * identifier = NSStringFromClass([self class]);
	
	[collectionView registerClass:self forCellWithReuseIdentifier:identifier];
	
	UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	return cell;
}

@end
