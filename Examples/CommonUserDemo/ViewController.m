//
//  ViewController.m
//  CommonUserDemo
//
//  Created by 炬盈科技 on 2017/11/24.
//  Copyright © 2017年 github/cjq002. All rights reserved.
//

#import "ViewController.h"

#import "MyUser.h"	// 一般足够使用
#import "CLUser.h"	// 带模型转换字段映射

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 网络获取到的数据
	NSDictionary *networkData = @{@"id":@"NO123456", @"userName":@"帅气的钱包", @"mobile":@"10086", @"profile":@{@"money":@100,@"qq":@"692771080"}};
	
	// MARK: - 示例一：MyUser
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
	// [MyUser logout];
	
	
	// MARK: - 示例二：CLUser
	[CLUser saveUserData:networkData];
	
	CLUser *newUser = [CLUser currentUser];
	// userId不好操作，id被映射到userId
	NSLog(@"%@ %@", newUser.userId, newUser.userName);
	// 输出保存的数据
	NSLog(@"%@", [CLUser allData]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
