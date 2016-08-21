# SHToAppStore
##引导客户跳转到AppStore评论
##
![image](https://github.com/zsh7887/SHToAppStore/blob/master/123.png)
##

```java  
SHToAppStore *toAppStore = [[SHToAppStore alloc]init];
//一定要这里调用Alert 如果在子类调用程序会崩溃
toAppStore.IOS7AlertViewBlock = ^{
UIAlertView * alertViewTest = [[UIAlertView alloc] initWithTitle:toAppStore.title message:toAppStore.message delegate:toAppStore cancelButtonTitle:nil otherButtonTitles:@"😭残忍拒绝",@"😓我要吐槽",@"😄好评赞赏", nil];
[alertViewTest show];
};
[toAppStore showGotoAppStore];
});
```