//
//  ViewController.m
//  SHToAppStore
//
//  Created by 8Bitdo_Dev on 16/8/18.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#import "ViewController.h"
#import "SHToAppStore.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //意见反馈
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SHToAppStore *toAppStore = [[SHToAppStore alloc]init];
        //一定要这里调用Alert 如果在子类调用程序会崩溃
        toAppStore.IOS7AlertViewBlock = ^{
            UIAlertView * alertViewTest = [[UIAlertView alloc] initWithTitle:toAppStore.title message:toAppStore.message delegate:toAppStore cancelButtonTitle:nil otherButtonTitles:@"😭残忍拒绝",@"😓我要吐槽",@"😄好评赞赏", nil];
            [alertViewTest show];
        };
        [toAppStore showGotoAppStore];
         
        
    });
}


@end
