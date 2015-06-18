//
//  WaterFlowLayout.m
//  testCollectionView
//
//  Created by shenqiang on 15/4/28.
//  Copyright (c) 2015年 shenqiang. All rights reserved.
//

#import "WaterFlowLayout.h"


@interface WaterFlowLayout(){
    
    __weak id<WaterFlowLayoutDelegate> _delegate;
    CGSize _contentSize;
    NSMutableArray *_attributesArray;
    NSInteger  _itemCount;
    
}

@end

@implementation WaterFlowLayout

-(instancetype)init{
    
    if(self = [super init]){
       
    }
    return self;
}

- (void)prepareLayout{
    
    [super prepareLayout];
    
    CGFloat _maxHeight = 0;
    
    _delegate = (id<WaterFlowLayoutDelegate>)self.collectionView.delegate;
    if (_attributesArray == nil)
    {
        _attributesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    for (NSUInteger i = 0 ; i< ([self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView]); i++) {
        
        _itemCount +=[self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:i];
        
        
        
        CGFloat _width = ([UIScreen mainScreen].bounds.size.width - [_delegate collectionView:self.collectionView layout:self hSpacingForSectionAtIndex:i]*([_delegate collectionView:self.collectionView layout:self columnForSectionAtIndex:i]-1)-[_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].left - [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].right)/[_delegate collectionView:self.collectionView layout:self columnForSectionAtIndex:i];
        
        for(NSUInteger col = 0; col<([_delegate collectionView:self.collectionView layout:self columnForSectionAtIndex:i]); col++){
            
            CGFloat _vSpace = 0;
            CGFloat _height = 0;
            
            NSUInteger index = col;
            while (index< [self.collectionView.dataSource  collectionView:self.collectionView numberOfItemsInSection:i]) {
                
               
                    
                UICollectionViewLayoutAttributes *attributes =
                [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:index inSection:i]];
                
                attributes.frame = CGRectMake([_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].left+(_width+[_delegate collectionView:self.collectionView layout:self hSpacingForSectionAtIndex:i])*col,_vSpace+_height+[_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].top ,_width,_width/[_delegate collectionView:self.collectionView layout:self aspectrRatioForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:i]]);
                
                attributes.size = CGSizeMake(_width, _width/[_delegate collectionView:self.collectionView layout:self aspectrRatioForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:i]]);
                    attributes.hidden = NO;
                
                    _vSpace += [_delegate collectionView:self.collectionView layout:self vSpacingForSectionAtIndex:i];
                
                    
                    _height += _width/[_delegate collectionView:self.collectionView layout:self aspectrRatioForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:i]];
                    
                    _maxHeight = _height+_vSpace+[_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].top+[_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].bottom>_maxHeight?_height+_vSpace+[_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].top+[_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i].bottom:_maxHeight;
                    
                    [_attributesArray addObject:attributes];
                    index = index + [_delegate collectionView:self.collectionView layout:self columnForSectionAtIndex:i];
                    
               
                
            }
        }
        
        
    }
    
    _contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-10
                              
                              
                              ,_maxHeight);

   
    
}

- (void)invalidateLayout
{
    [super invalidateLayout];
    
    _attributesArray = nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

-(CGSize)collectionViewContentSize{
    
        return _contentSize;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:1];
    
    for (UICollectionViewLayoutAttributes * _attributes in _attributesArray) {
       
        if ( CGRectIntersectsRect(rect, _attributes.frame)) {
            [attributesArray addObject:_attributes];
            
        }
    }
    
    return attributesArray;
    
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSUInteger index = 0;
    
    for (NSUInteger section = 0; section  < indexPath.section; section++) {
        index += [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];

    }
    
    NSUInteger totoalColumn = [_delegate collectionView:self.collectionView layout:self columnForSectionAtIndex:indexPath.section];
    
    NSUInteger totalRow = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:indexPath.section]/totoalColumn;
    
    NSUInteger  add =[self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:indexPath.section]%totoalColumn;
    
    
    if ( add !=0) {
        totalRow++;
    }
    
    
    NSUInteger colum = indexPath.item%totoalColumn;
    
    NSUInteger row = indexPath.item/totoalColumn;
    
    return _attributesArray[ colum*totalRow+row-(add!=0?(colum>add?(colum-add):0):0) +index];
    
}


@end
