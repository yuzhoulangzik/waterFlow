//
//  WaterFlowLayoutDelegate.h
//  testCollectionView
//
//  Created by 沈强 on 15/4/29.
//  Copyright (c) 2015年 shenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WaterFlowLayoutDelegate <UICollectionViewDelegate>

@required

/**
 *
 *
 *  @return 返回宽高比
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout aspectrRatioForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 *
 *
 *  @return列数
 */

- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout columnForSectionAtIndex:(NSInteger)section;

/**
 *
 *
 *
 *  @return 边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
/**
 *
 *
 *
 *  @return 水平间距
 */

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout hSpacingForSectionAtIndex:(NSInteger)section;
/**
 *
 *
 *
 *  @return 垂直间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout vSpacingForSectionAtIndex:(NSInteger)section;



@end
