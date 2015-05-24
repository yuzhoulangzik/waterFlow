//
//  TestCollectionViewController.m
//  testCollectionView
//
//  Created by shenqiang on 15/4/28.
//  Copyright (c) 2015年 shenqiang. All rights reserved.
//

#import "TestCollectionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CollectionViewCell.h"
@interface TestCollectionViewController (){
    ALAssetsLibrary *library;
    NSMutableArray  *photoArray;
}

@end

@implementation TestCollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.collectionView.delegate =nil;
    self.collectionView.dataSource = nil;
    self.view.backgroundColor = [UIColor redColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self reloadData];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
   
}

- (void)reloadData
{
    
  
    photoArray = [NSMutableArray arrayWithCapacity:0];
    library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes: ALAssetsGroupSavedPhotos  usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            
            
            *stop = YES;
            if(!group.numberOfAssets == 0){
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        [photoArray addObject:result];
                        
                    }
                }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.collectionView.delegate =self;
                self.collectionView.dataSource = self;
                 [self.collectionView.collectionViewLayout invalidateLayout];
               [self.collectionView reloadData];
                
            
            
            });
            
        }
        
    } failureBlock:^(NSError *error) {
       
    }];
}

-(void)show{
    NSLog(@"%@",self.collectionView.subviews);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
      return 1;
   
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    [collectionView.collectionViewLayout invalidateLayout];
      return photoArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (![UIImage imageWithCGImage:((ALAsset*)[photoArray objectAtIndex:indexPath.item]).thumbnail]) {
        NSLog(@"===================== nil");
    }
    cell.imageView.image = [UIImage imageWithCGImage:((ALAsset*)[photoArray objectAtIndex:indexPath.item]).thumbnail];
    // Configure the cell
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/**
 *
 *
 *  @return 返回宽高比
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout aspectrRatioForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item%2==1) {
      return 1/2.0;
    }else{
       return 2/3.0;
    }
    
    
   
}

/**
 *
 *
 *
 *  @return列数
 */

- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout columnForSectionAtIndex:(NSInteger)section{
    return 3.0;
}

/**
 *
 *
 *
 *  @return 边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(5, 5, 5, 5);
}
/**
 *
 *
 *
 *  @return 水平间距
 */

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout hSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}
/**
 *
 *
 *
 *  @return 垂直间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout vSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0;
}



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
