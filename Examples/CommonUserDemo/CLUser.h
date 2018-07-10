//
//  CLUser.h
//  CommonUserDemo
//
//  Created by CJQ on 2018/7/10.
//  Copyright © 2018年 github/cjq002. All rights reserved.
//

#import <CommonUser/CommonUser.h>
#import <YYModel/YYModel.h>

@interface CLUser : CommonUser<NSCoding, NSCopying>

@property (nonatomic, copy) NSString *userId;           //用户ID
@property (nonatomic, copy) NSString *sessionToken;     //用户标识

/**
 *  获取当前缓存用户、如果init的话会初始化新的对象
 *
 *  @return 返回当前缓存用户信息
 */
+ (instancetype)currentUser;

/**
 登出，清空数据
 */
+ (void)logout;

/**
 检查用户登录状态
 */
+ (BOOL)isLogin;

/**
 更新数据，set方法是不存储的
 
 @param userData 对象
 */
+ (void)saveUserData:(NSDictionary *)userData;

/**
 获取所以用户数据

 @return 字典集合
 */
+ (NSDictionary *)allData;

@end
