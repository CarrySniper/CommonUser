# CommonUser
基于NSUserDefaults封装的用户数据持久化类，可以更新用户数据，获取当前用户信息和退出登录销毁信息。继承该类就可以直接扩展用户字段。<br>
退出App会保留存储的数据，下次启动可以+(id)currentUser;获取保存的信息。

### 使用方法
#### 1.安装
方法一：使用CocoaPods安装：<br>
```
 pod 'CommonUser'
 ```
方法二：直接下载文件夹CommonUser（内含两个.h.m文件），拖到您的项目工程里面。

#### 2.使用
新建文件MyUser继承于CommonUser。

#### 3.为MyUser添加属性，即可实例化对象进行操作。
 
```
    // 保存数据
    [MyUser update:@{@"Mobile":@"10086", @"Name":@"帅气的钱包",@"CreateDate":@"2017-11-11"}];
    
    // 清除数据
    // [MyUser logout];
    
    // 获取数据
    MyUser *user = [MyUser currentUser];
    if (!user) {
        NSLog(@"对象不存在");
    }else{
        NSLog(@"%@ %@", user.Mobile, user.Name);
    }
```
NSlog结果： 10086 帅气的钱包
