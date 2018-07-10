# CommonUser
基于NSUserDefaults封装的用户数据持久化类，可以更新用户数据，获取当前用户信息和退出登录销毁信息。继承该类就可以直接扩展用户字段。<br>
退出App会保留存储的数据，下次启动可以+(id)currentUser;获取保存的信息。<br>
另外提供YYModel模型转换存储类CLUser，方便字段映射。

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
// 网络获取到的数据
NSDictionary *networkData = @{@"id":@"NO123456", @"userName":@"帅气的钱包", @"mobile":@"10086", @"profile":@{@"money":@100,@"qq":@"692771080"}};
```
示例一：MyUser
``` 
    [MyUser saveUserData:networkData];
    
    // 获取数据
    MyUser *user = [MyUser currentUser];
    if (!user) {
        NSLog(@"对象不存在");
    }else{
        // user.id不好操作，id为系统语言关键字
        NSLog(@"%@ %@", user.mobile, user.userName);
    }

    // 清除数据
    //[MyUser logout];
```
示例二：CLUser
```
    [CLUser saveUserData:networkData];
    
    CLUser *newUser = [CLUser currentUser];
    // userId不好操作，id被映射到userId
    NSLog(@"%@ %@", newUser.userId, newUser.userName);

    // 输出保存的数据
    NSLog(@"%@", [CLUser allData]);
```

#### NSlog结果： 
```
10086 帅气的钱包
NO123456 帅气的钱包
{
    id = NO123456;
    profile =     {
        money = 100;
        qq = 692771080;
    };
    userName = "\U5e05\U6c14\U7684\U94b1\U5305";
}
```
