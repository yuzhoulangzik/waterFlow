//
//  CollectionViewCell.m
//  testCollectionView
//
//  Created by shenqiang on 15/4/28.
//  Copyright (c) 2015年 shenqiang. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
         _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_imageView];
        
        self.contentView.backgroundColor = [UIColor redColor];
    
    }
    return self;
}

- (void)prepareForReuse{
    
    [super prepareForReuse];
  
//    _imageView.bounds = self.contentView.bounds ;
    
}


@end
