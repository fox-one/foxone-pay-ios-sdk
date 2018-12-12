//
//  ViewController.m
//  SDKOCDemo
//
//  Created by moubuns on 2018/12/12.
//  Copyright © 2018 FoxOne. All rights reserved.
//

#import "ViewController.h"
#import "FoxAsset.h"
#import "SDKOCDemo-Swift.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FoxPaySDKHelper getAssetWithCompleted:^(NSArray<FoxAsset *> * _Nonnull assets) {
        [assets enumerateObjectsUsingBlock:^(FoxAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@", obj.name);
        }];
    }];
}


@end
