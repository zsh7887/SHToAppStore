# SHToAppStore
##引导客户跳转到AppStore评论
##
![image](https://github.com/zsh7887/SHToAppStore/blob/master/123.png)
##

```objc  
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
```