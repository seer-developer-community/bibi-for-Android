//
//  SwichLanguage.m
//  BiBi
//
//  Created by 武建斌 on 2019/2/11.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "SwichLanguage.h"

static NSString*LocalLanguageKey = @"SwitchLanguage";

@interface SwichLanguage ()

@property(nonatomic,strong)NSBundle *bundle;

@property(nonatomic,copy)NSString *language;

@end

@implementation SwichLanguage





static NSBundle *bundle = nil;



//+ ( NSBundle * )bundle{
//
//    return bundle;
//
//}
//
//
//
////首次加载的时候先检测语言是否存在
//
//
//
//+(void)initUserLanguage{
//
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//
//    NSString *currLanguage = [def valueForKey:LocalLanguageKey];
//
//
//
//    if(!currLanguage){
//
//
//
//        NSArray *preferredLanguages = [NSLocale preferredLanguages];
//
//
//
//        currLanguage = preferredLanguages[0];
//
//
//
//        if ([currLanguage hasPrefix:@"en"]) {
//
//
//
//            currLanguage = @"en";
//
//
//
//        }else if ([currLanguage hasPrefix:@"zh"]) {
//
//
//
//            currLanguage = @"zh-Hans";
//
//
//
//        }else currLanguage = @"en";
//
//
//
//        [def setValue:currLanguage forKey:LocalLanguageKey];
//
//
//
//        [def synchronize];
//
//
//
//    }
//
//
//
//
//
//    //获取文件路径
//
//
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
//
//
//
//    bundle = [NSBundle bundleWithPath:path];//生成bundle
//
//
//
//}
//
//
//
////获取当前语言
//
//
//
//+(NSString *)userLanguage{
//
//
//
//
//
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//
//
//
//
//
//    NSString *language = [def valueForKey:LocalLanguageKey];
//
//
//
//
//
//    return language;
//
//
//
//}
//
//
//
////设置语言
//
//
//
//+(void)setUserlanguage:(NSString *)language{
//
//
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//
//
//    NSString *currLanguage = [userDefaults valueForKey:LocalLanguageKey];
//
//
//
//    if ([currLanguage isEqualToString:language]) {
//
//
//
//        return;
//
//
//
//    }
//
//
//
//    [userDefaults setValue:language forKey:LocalLanguageKey];
//
//    [userDefaults synchronize];
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
//
//
//    bundle = [NSBundle bundleWithPath:path];
//
//}
@end
