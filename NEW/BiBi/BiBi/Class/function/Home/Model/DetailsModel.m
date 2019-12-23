//
//  DetailsModel.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "DetailsModel.h"

@implementation DetailsModel
{
    BOOL isTransForm;
}

- (CGFloat)hight {
    if (_hight) {
        return _hight;
    }
    _hight = 0;
    CGFloat tiemHeight = 34.0;
    CGFloat btnHeight = 33.0;
    CGFloat toolHeight = 30;
    CGFloat btnMarginTop = 16;
    CGFloat btnMarginBottom = 13;
    NSString *conTitle = [self handleStringWithString:_title];
    NSString *Ctitle = [self handleStringWithString2:conTitle];

    CGRect rect  = [Ctitle boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 12.5]} context:nil];
    NSLog(@"caclutare ---%f---%@",rect.size.height,_title);
    
    _hight = tiemHeight +rect.size.height +btnMarginTop+btnMarginBottom+toolHeight+btnHeight+topMargin;
    NSLog(@"higt-----%f",_hight);
    return _hight;
}


-(CGFloat)hightH{
    
        if (_hightH) {
    
            return _hightH;
        }
    
    _hightH = 0;
    CGFloat tiemHeight = 50.0;
    CGFloat btnMarginTop = 16;
    
    CGFloat countitleTop = 16;
    CGFloat chooseBnt = 30 * self.choseButcount.count;
    CGFloat toolHeight = 68;
    
    CGFloat xuanzeHeight = 48;
    NSString *conTitle = [self handleStringWithString:_title];
    NSString *Ctitle = [self handleStringWithString2:conTitle];
    CGRect rect  = [Ctitle boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 12]} context:nil];
    NSLog(@"caclutare ---%f---%@",rect.size.height,_title);
    _hightH = tiemHeight + btnMarginTop +rect.size.height +countitleTop +chooseBnt + toolHeight + xuanzeHeight;
    
    NSLog(@"higt-----%f",chooseBnt);
    return _hightH;
    
   
}


-(CGFloat)yuchengHight{
    
    if (_yuchengHight) {
        
        return _yuchengHight;
    }
    
    _yuchengHight = 0;
    
    CGFloat tiemHeight = 40.0;
    
    CGFloat btnMarginTop = 30;
    NSString *conTitle = [self handleStringWithString:_title];
    NSString *Ctitle = [self handleStringWithString2:conTitle];
    CGRect rect  = [Ctitle boundingRectWithSize:CGSizeMake(ScreenWidth - 40, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 12]} context:nil];
    
    CGFloat labelMarginTop = 40;
    
    CGFloat timemarginTop = 60;
    
    _yuchengHight = tiemHeight +btnMarginTop +rect.size.height +labelMarginTop +timemarginTop;
    
    return _yuchengHight;
}



- (NSString *)time {
//    if (_time && isTransForm) {
//        return _time;
//    }
    if (!_time) {
        return @"";
    }
    NSString * tempTime = [_time stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *data = [formatter dateFromString:tempTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: data];
    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
    NSString *newString = [formatter stringFromDate:localeDate];
//    NSString *cnNewString = NSLocalizedStringFromTable(@"time",@"Internation", nil);
    return newString;
    
////    NSString *string = @"2016-7-16 09:33:22";// 日期格式化类
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


- (NSString *)time1{
    //    if (_time && isTransForm) {
    //        return _time;
    //    }
    if (!_time1) {
        return @"";
    }
    NSString * tempTime = [_time stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString * tempTimeGMT = [NSString stringWithFormat:@"%@ GMT",tempTime];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *data = [formatter dateFromString:tempTime];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: data];
//    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
//    NSString *newString = [formatter stringFromDate:localeDate];
//    //    NSString *cnNewString = NSLocalizedStringFromTable(@"time",@"Internation", nil);
//    return newString;
    
    ////    NSString *string = @"2016-7-16 09:33:22";// 日期格式化类
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
    
     return tempTimeGMT;
}



-(NSString *)startTimer{
    
    if (!_startTimer) {
        return @"";
    }
    NSString * tempTime = [_startTimer stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *data = [formatter dateFromString:tempTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: data];
    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
    NSString *newString = [formatter stringFromDate:localeDate];
    
    
    
    return newString;
}


-(NSString *)accept_asset{
    if (!_accept_asset) {
        return @"";
    }

    if ([_accept_asset isEqualToString:@"1.3.0"]) {
        _accept_asset = @"SEER";
    }else if ([_accept_asset isEqualToString:@"1.3.5"]){
        _accept_asset = @"USDT";
    }else if ([_accept_asset isEqualToString:@"1.3.2"]){
        _accept_asset = @"PFC";
    }
    
    return _accept_asset;
}


//取消中括号
-(NSString *)handleStringWithString:(NSString *)str{
    
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"@#-("];
        NSRange range1 = [muStr rangeOfString:@")"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    
    return muStr;
}


//二次取消
-(NSString *)handleStringWithString2:(NSString *)str{
    
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"("];
        NSRange range1 = [muStr rangeOfString:@")"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    
    return muStr;
}

@end
