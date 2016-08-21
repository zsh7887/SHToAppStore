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
        //在Appstore 的URL
        toAppStore.myAppURL = @"https://itunes.apple.com/cn/app/8bitdo/id1134414956?mt=8";
        
        //如果要适配IOS7 需要调用
        __weak typeof(toAppStore) IOS7ToAppStore = toAppStore;//解决内存泄漏
        toAppStore.IOS7AlertViewBlock = ^{
            //一定要这里调用Alert 如果在子类调用程序会崩溃
            UIAlertView * alertViewTest = [[UIAlertView alloc] initWithTitle:IOS7ToAppStore.title message:IOS7ToAppStore.message delegate:IOS7ToAppStore cancelButtonTitle:nil otherButtonTitles:@"😭残忍拒绝",@"😓我要吐槽",@"😄好评赞赏", nil];
            [alertViewTest show];
        };
        //显示
        [toAppStore showGotoAppStore];
    });
}


@end
