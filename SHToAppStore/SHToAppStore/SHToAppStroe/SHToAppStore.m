//
//  SHToAppStore.m
//  SHToAppStore
//
//  Created by 8Bitdo_Dev on 16/8/18.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#import "SHToAppStore.h"


#define LastOpenData @"lastOpenData"
#define LastVersion @"LastVersion"
#define LastSelectState @"LastSelectState"
//判断时间 点击了对应的按钮所需的天数 下次弹出appstore对话框
#define ShowRefusalDay 3
#define ShowComplaintsDay 8
#define ShowPraiseDay 16


typedef enum : NSUInteger {
    stateRefusal=1,    // 残忍拒绝
    stateComplaints,    //我要吐槽
    statePraise         //好评
} lastSelectStateEunm;


@implementation SHToAppStore
- (void)showGotoAppStore{
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //当前的版本
    CGFloat currentVersion = [infoDict[@"CFBundleShortVersionString"] floatValue];
    //上次打开的时间   上次打开的版本  上次选择的选项
    NSDate *lastOpenDate = [[NSUserDefaults standardUserDefaults]objectForKey:LastOpenData];
    CGFloat lastVersion = [userDefault floatForKey:LastVersion];
    NSString *lastSelectState = [userDefault stringForKey:LastSelectState];
    //存储打开的时间 和 版本
    [userDefault setFloat:currentVersion forKey:LastVersion];
    [userDefault synchronize];
    if (lastOpenDate==nil || currentVersion != lastVersion) {//第一次打开 和 当前版本不对应（证明客户升级版本了）
        [userDefault setObject:[NSDate date] forKey:LastOpenData];
        [userDefault removeObjectForKey:LastSelectState];
        return;
    }
    //比较时间值
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component =  [calendar components:NSCalendarUnitDay fromDate:lastOpenDate toDate:[NSDate date] options:0];
    NSInteger disDay = component.day;
    //判断用户上一次选择的状态
    //1残忍拒绝
    //2我要吐槽
    //3我要赞赞
    if (lastSelectState) {
        NSInteger lastSelectStateInt = [lastSelectState integerValue];
        if ((lastSelectStateInt==stateRefusal && disDay>=ShowRefusalDay) ||
            (lastSelectStateInt==stateComplaints && disDay >=ShowComplaintsDay) ||
            (lastSelectStateInt==statePraise && disDay >=ShowPraiseDay)
            ) {
            //保存时间
            [self alertUserCommentView];
        }
    }else{
        //第二次打开时 判断时间间隔是否为2天
        if (disDay>=ShowRefusalDay) {
            [self alertUserCommentView];
        }
    }
    
}

-(void)alertUserCommentView{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSDate date] forKey:LastOpenData];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0) {
        alertController = [UIAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *refuseAction = [UIAlertAction actionWithTitle:@"😭残忍拒绝" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            [userDefault setInteger:stateRefusal forKey:LastSelectState];
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"😄好评赞赏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [userDefault setInteger:statePraise forKey:LastSelectState];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.myAppURL]];
        }];
        
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"😓我要吐槽" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [userDefault setInteger:stateComplaints forKey:LastSelectState];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.myAppURL]];
        }];
        
        
        [alertController addAction:refuseAction];
        [alertController addAction:okAction];
        [alertController addAction:showAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }else{// ios 7
        if (self.IOS7AlertViewBlock) {
            self.IOS7AlertViewBlock();
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    switch (buttonIndex+1) {
        case stateRefusal:
            [userDefault setInteger:stateRefusal forKey:LastSelectState];
            break;
        case stateComplaints:

            [userDefault setInteger:stateComplaints forKey:LastSelectState];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.myAppURL]];
            break;
        case statePraise:
            
            [userDefault setInteger:statePraise forKey:LastSelectState];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.myAppURL]];
            break;
        default:
            break;
    }
}

-(NSString *)title{
    return _title==nil?@"致开发者的一封信":_title;
}
-(NSString *)message{
    return _message==nil?@"有了您的支持才能更好的为您服务，提供更加优质的，更加适合您的App，当然您也可以直接反馈问题给到我们":_message;
}

-(void)dealloc{
    NSLog(@"SHToAppStore.h");
}
@end
