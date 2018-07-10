//
//  CLUser.m
//  CommonUserDemo
//
//  Created by CJQ on 2018/7/10.
//  Copyright © 2018年 github/cjq002. All rights reserved.
//

#import "CLUser.h"

@implementation CLUser

#pragma mark 当前登录用户
+ (instancetype)currentUser {
	return [super currentUser];
}

#pragma mark 用户登出
+ (void)logout {
	[super logout];
}

#pragma mark 检查用户登录状态
+ (BOOL)isLogin {
	CLUser *user = [self currentUser];
	if (user.sessionToken.length == 0) {
		return NO;
	}
	return YES;
}

#pragma mark 保存用户信息
+ (void)saveUserData:(NSDictionary *)userData {
	// 因为下面的User会把没有的键赋初值，不合适我们更新数据逻辑，所以就的遍历更新
	NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithDictionary:[self allData]];
	for (NSString *key in userData.allKeys) {
		[tempDictionary setValue:userData[key] forKey:key];
	}
	// 避免字段映射错误
	CLUser *user = [CLUser yy_modelWithJSON:tempDictionary];
	[super update:[CLUser dictionaryFromObject:user]];
}

#pragma mark 获取所以用户数据
+ (NSDictionary *)allData {
	return [[CLUser currentUser] yy_modelToJSONObject];
}

#pragma mark - 以下是YYModel的
/*
 YYModel扩展使用，视情况选择实现
 
 #pragma mark - 字段映射。{"自定义字段":"目标字段"}
 + (NSDictionary *)modelCustomPropertyMapper {
 return @{@"name" : @"n"};
 }
 #pragma mark - Model包含其他Model。 {"目标字段":"Model的类"} (以 Class 或 Class Name 的形式)。
 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"common" : [CommonModel class]};
 }
 #pragma mark - 黑名单。如果实现了该方法，则处理过程中会忽略该列表内的所有属性
 + (NSArray *)modelPropertyBlacklist {
 return @[@"name"];
 }
 #pragma mark - 白名单。如果实现了该方法，则处理过程中不会处理该列表外的属性。
 + (NSArray *)modelPropertyWhitelist {
 return @[@"name"];
 }
 */
#pragma mark - 字段映射。{"自定义字段":"目标字段"}
+ (NSDictionary *)modelCustomPropertyMapper {
	return @{@"userId" : @"id"};
}

#pragma mark - 直接添加以下代码即可自动完成序列化／反序列化
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone {
	return [self yy_modelCopy];
}
- (NSUInteger)hash {
	return [self yy_modelHash];
}
- (BOOL)isEqual:(id)object {
	return [self yy_modelIsEqual:object];
}
- (NSString *)description {
	return [self yy_modelDescription];
}

@end
