//
//  SHToAppStore.h
//  SHToAppStore
//
//  Created by 8Bitdo_Dev on 16/8/18.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHToAppStore : NSObject
{
    UIAlertController *alertController;
    
}
@property (nonatomic,copy) NSString * myAppURL;//appID
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *message;

@property (nonatomic,copy) void(^IOS7AlertViewBlock)();


- (void)showGotoAppStore;

@end
