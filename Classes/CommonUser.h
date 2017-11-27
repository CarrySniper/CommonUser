//
//  CommonUser.h
//
//
//  Created by CJQ&LY on 2017/10/31.
//

#import <Foundation/Foundation.h>

@interface CommonUser : NSObject

/*
 继承该类，属性字段添加如下：
 @property (nonatomic, copy) NSString *userId;
 @property (nonatomic, copy) NSString *userName;
*/

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
 更新数据，set方法是不存储的
 
 @param dictionary 对象
 */
+ (void)update:(NSDictionary *)dictionary;

@end
