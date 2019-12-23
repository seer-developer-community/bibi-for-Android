//
//  SwichLanguage.h
//  BiBi
//
//  Created by 武建斌 on 2019/2/11.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwichLanguage : NSObject

////+ (instancetype)standardHelper;
//
//+(NSBundle *)bundle;//获取当前资源文件
//
//
//
//+(void)initUserLanguage;//初始化语言文件
//
//
//
//+(NSString *)userLanguage;//获取应用当前语言
//
//
//
//+(void)setUserlanguage:(NSString *)language;//设置当前语言


+(id)sharedInstance;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

/**
 *  改变当前语言
 */
-(void)changeNowLanguage;

/**
 *  设置新的语言
 *
 *  @param language 新语言
 */
-(void)setNewLanguage:(NSString*)language;





@end

NS_ASSUME_NONNULL_END
