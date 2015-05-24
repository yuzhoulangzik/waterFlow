//
//  ViewController.m
//  testWaterFlow
//
//  Created by 沈强 on 15/5/24.
//  Copyright (c) 2015年 沈强. All rights reserved.
//

#import "ViewController.h"
#import "TestCollectionViewController.h"
#import "WaterFlowLayout.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)test:(id)sender{
    TestCollectionViewController * test = [[TestCollectionViewController alloc]initWithCollectionViewLayout:[WaterFlowLayout new]];
    //    [self presentViewController:test animated:YES completion:NULL];
    [self addChildViewController:test];
    [self.view addSubview:test.view];
}
@end
