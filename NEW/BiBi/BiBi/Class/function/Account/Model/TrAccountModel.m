//
//  TrAccountModel.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/6.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "TrAccountModel.h"

@implementation TrAccountModel


- (NSString *)dataTime{
    //    if (_time && isTransForm) {
    //        return _time;
    //    }
    if (!_dataTime) {
        return @"";
    }
    NSString * tempTime = [_dataTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *data = [formatter dateFromString:tempTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: data];
    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
    NSString *newString = [formatter stringFromDate:localeDate];
    return newString;
    //    NSString * formaterStr = @"YYYY-MM-dd HH:mm:ss";
    //    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    //    dateFormater.dateFormat = formaterStr;
    //    NSDate * tempDate = [dateFormater dateFromString:tempTime];
    //    NSTimeInterval tmepTimeNums = [tempDate timeIntervalSince1970];
    //    NSTimeInterval finalSeconds = tmepTimeNums + 8 * 60 * 60;
    //    NSDate * finalDate = [NSDate dateWithTimeIntervalSince1970:finalSeconds];
    //    NSString * finalDateStr =  [dateFormater stringFromDate:finalDate];
    //    isTransForm = YES;
    //    return finalDateStr;
}

@end
