//
//  CommonUser.m
//
//
//  Created by CJQ&LY on 2017/10/31.
//

#import "CommonUser.h"
#import <objc/runtime.h>

/** UserDefaults专用key标识 */
static NSString *const kCommonUserDefaultsKey           = @"commonUserKeyOf";
/** User存储主键 */
static NSString *const kPrimaryKeyForCommonUser         = @"primaryKeyOfCommonUser";


@implementation CommonUser

#pragma mark -
#pragma mark 单例初始化
static CommonUser *instance = nil;
static dispatch_once_t onceToken;
+ (instancetype)currentUser
{
    //如果保存过，则返回User对象；否则返回nil
    if (![[NSUserDefaults standardUserDefaults] valueForKey:kPrimaryKeyForCommonUser]) {
        return nil;
    }
    dispatch_once(&onceToken, ^{
        instance = [self getUser];
    });
    return instance ;
}

#pragma mark 销毁单例
+ (void)destroy
{
    onceToken = 0l;
    instance = nil;
}

#pragma mark - 退出登录，移除数据
+ (void)logout {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:[self allKeysWithClass:[CommonUser class]]];
    [array addObjectsFromArray:[self allKeys]];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[CommonUser appendingString:obj]];
        if ([obj isEqualToString:array.lastObject]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPrimaryKeyForCommonUser];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    // 销毁
    [CommonUser destroy];
}


#pragma mark - User的setter方法，存储数据，要重新赋值单例
+ (void)update:(NSDictionary *)dictionary {
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj && ![obj isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:obj forKey:[CommonUser appendingString:key]];
        }
        if ([key isEqualToString:dictionary.allKeys.lastObject]) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kPrimaryKeyForCommonUser];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    [self getUser];
}

#pragma mark - User的getter方法，读取数据
+ (CommonUser *)getUser {
    instance = [[self alloc]init];
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObjectsFromArray:[self allKeysWithClass:[CommonUser class]]];
    [array addObjectsFromArray:[self allKeys]];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = [[NSUserDefaults standardUserDefaults] valueForKey:[CommonUser appendingString:obj]];
        if (value) {
            [instance setValue:value forKey:obj];
        }
    }];
    return instance;
}

#pragma mark - 拼接Key
+ (NSString *)appendingString:(NSString *)string {
    return [NSString stringWithFormat:@"%@%@", kCommonUserDefaultsKey, string];
}

#pragma mark - 获取本类的所有属性
+ (NSArray *)allKeys {
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char* char_p = property_getName(property);
        [array addObject:[NSString stringWithUTF8String:char_p]];
    }
    free(properties);
    return array;
}

#pragma mark - 获取指定类的所有属性
+ (NSArray *)allKeysWithClass:(Class)fireClass {
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(fireClass, &count);
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char* char_p = property_getName(property);
        [array addObject:[NSString stringWithUTF8String:char_p]];
    }
    free(properties);
    return array;
}

#pragma mark - 对象转换为字典
+ (NSDictionary *)dictionaryFromObject:(id)object {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	unsigned int propsCount;
	
	objc_property_t *props = class_copyPropertyList([object class], &propsCount);
	
	for (int i = 0; i < propsCount; i++) {
		objc_property_t prop = props[i];
		NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
		id value = [object valueForKey:propName];
		if(value == nil) {
			value = [NSNull null];
		} else {
			value = [self getObjectInternal:value];
		}
		[dict setObject:value forKey:propName];
	}
	return dict;
}

+ (id)getObjectInternal:(id)object {
	
	if([object isKindOfClass:[NSString class]] ||
	   [object isKindOfClass:[NSNumber class]] ||
	   [object isKindOfClass:[NSNull class]]) {
		return object;
	}
	if ([object isKindOfClass:[NSArray class]]) {
		NSArray *objArray = object;
		NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:objArray.count];
		for(int i = 0; i < objArray.count; i++) {
			[tempArray setObject:[self getObjectInternal:[objArray objectAtIndex:i]] atIndexedSubscript:i];
		}
		return tempArray;
	}
	if([object isKindOfClass:[NSDictionary class]]) {
		NSDictionary *objDict = object;
		NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:[objDict count]];
		
		for (NSString *key in objDict.allKeys) {
			[dict setObject:[self getObjectInternal:[objDict objectForKey:key]] forKey:key];
		}
		return dict;
	}
	return [self dictionaryFromObject:object];
}

@end
