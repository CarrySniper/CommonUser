//
//  ViewController.m
//  CommonUserDemo
//
//  Created by 炬盈科技 on 2017/11/24.
//  Copyright © 2017年 github/cjq002. All rights reserved.
//

#import "ViewController.h"
#import "MyUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
