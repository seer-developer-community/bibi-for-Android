//
//  OrderModel.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/8.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel


//- (CGFloat)hight {
//    if (_hight) {
//        return _hight;
//    }
//    _hight = 0;
////    CGFloat tiemHeight = 34.0;
////    CGFloat btnHeight = 33.0;
////    CGFloat toolHeight = 30;
//    CGFloat btnMarginTop = 15;
////    CGFloat btnMarginBottom = 13;
//
//    CGRect rect  = [_contentStr boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 11]} context:nil];
//        NSLog(@"caclutare ---%f---%@",rect.size.height,_contentStr);
//    CGRect rect1  = [_chooseStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]} context:nil];
//    NSLog(@"caclutare ---%f---%@",rect1.size.height,_chooseStr);
//
//    CGRect rect2  = [_timeOutStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size: 10.7]} context:nil];
//    NSLog(@"caclutare ---%f---%@",rect2.size.height,_timeOutStr);
//
//    _hight = rect.size.height +btnMarginTop*4 + rect1.size.height +rect2.size.height;
//        NSLog(@"order higt-----%f",_hight);
//    return _hight;
//}

- (CGFloat)getHeight {
    
    if (_hight) {
        return _hight;
    }
    _hight = 0;
    //    CGFloat tiemHeight = 34.0;
    //    CGFloat btnHeight = 33.0;
    //    CGFloat toolHeight = 30;
    CGFloat btnMarginTop = 15;
    //    CGFloat btnMarginBottom = 13;
    
//    CGRect rect  = [_contentStr boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 11]} context:nil];
    NSString *conTitle = [self handleStringWithString:_contentStr];
    NSString *Ctitle = [self handleStringWithString2:conTitle];
    
    CGRect rect  = [Ctitle boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];

    NSLog(@"caclutare ---%f---%@",rect.size.height,_contentStr);
    CGRect rect1  = [_chooseStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]} context:nil];
    NSLog(@"caclutare ---%f---%@",rect1.size.height,_chooseStr);
    
    CGRect rect2  = [_timeOutStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size: 10.7]} context:nil];
    NSLog(@"caclutare ---%f---%@",rect2.size.height,_timeOutStr);
    
//    CGRect rect3  = [_timeOutStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size: 10.7]} context:nil];
    NSLog(@"caclutare1111 ---%f---%@",rect2.size.height,_contentStr);
    
    _hight = rect.size.height +btnMarginTop*4 + rect1.size.height +rect2.size.height;
    NSLog(@"order higt-----%f",_hight);
    return _hight;

}





-(CGFloat)getroomtypeHeight{
    
    if (_hight) {
        return _hight;
    }
    _hight = 0;
    //    CGFloat tiemHeight = 34.0;
    //    CGFloat btnHeight = 33.0;
    //    CGFloat toolHeight = 30;
    CGFloat btnMarginTop = 15;
    //    CGFloat btnMarginBottom = 13;
    
    //    CGRect rect  = [_contentStr boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 11]} context:nil];
    NSString *conTitle = [self handleStringWithString:_contentStr];
    NSString *Ctitle = [self handleStringWithString2:conTitle];
    CGRect rect  = [Ctitle boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    NSLog(@"caclutare ---%f---%@",rect.size.height,_contentStr);
    CGRect rect1  = [_chooseStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]} context:nil];
    NSLog(@"caclutare ---%f---%@",rect1.size.height,_chooseStr);
    
    CGRect rect2  = [_timeOutStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size: 10.7]} context:nil];
    NSLog(@"caclutare ---%f---%@",rect2.size.height,_timeOutStr);
    
    _hight = rect.size.height +btnMarginTop*5 + rect1.size.height*2 +rect2.size.height;
    NSLog(@"order higt-----%f",_hight);
    return _hight;

    
    
}






- (NSString *)timeOutStr {
    //    if (_time && isTransForm) {
    //        return _time;
    //    }
    if (!_timeOutStr) {
        return @"";
    }
    NSString * tempTime = [_timeOutStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *data = [formatter dateFromString:tempTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: data];
    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
    NSString *newString = [formatter stringFromDate:localeDate];
    
    return newString;
  
}

-(NSString *)timeOutStrEN{
    if (!_timeOutStrEN) {
        return @"";
    }
    NSString * tempTime = [_timeOutStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString * tempTimeGMT = [NSString stringWithFormat:@"%@ GMT",tempTime];
    
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
    //    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    NSDate *data = [formatter dateFromString:tempTime];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate: data];
    //    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
    //    NSString *newString = [formatter stringFromDate:localeDate];
    return tempTimeGMT;
    
    
}





//头的高度
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
    NSString *conTitle = [self handleStringWithString:_contentStr];
    NSString *Ctitle = [self handleStringWithString2:conTitle];
    CGRect rect  = [Ctitle boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 12]} context:nil];
    
    NSLog(@"caclutare ---%f---%@",rect.size.height,_contentStr);
    _hightH = tiemHeight + btnMarginTop +rect.size.height +countitleTop +chooseBnt + toolHeight + xuanzeHeight;
    
    NSLog(@"higt-----%f",chooseBnt);
    return _hightH;
    
    
}


- (NSString *)timeStop {
    //    if (_time && isTransForm) {
    //        return _time;
    //    }
    if (!_timeStop) {
        return @"";
    }
    NSString * tempTime = [_timeStop stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *data = [formatter dateFromString:tempTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: data];
    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
    NSString *newString = [formatter stringFromDate:localeDate];
    return newString;
  
}


-(NSString *)timeStopEN{
    if (!_timeStopEN) {
        return @"";
    }
    NSString * tempTime = [_timeStop stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString * tempTimeGMT = [NSString stringWithFormat:@"%@ GMT",tempTime];
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;// 设置日期格式 为了转换成功
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *data = [formatter dateFromString:tempTime];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: data];
//    NSDate *localeDate = [data  dateByAddingTimeInterval: interval];
//    NSString *newString = [formatter stringFromDate:localeDate];
    return tempTimeGMT;
    
    
}


-(CGFloat)yuchengHight{
    
    if (_yuchengHight) {
        return _yuchengHight;
    }
    
    _yuchengHight = 0;
    
    CGFloat tiemHeight = 40.0;
    
    CGFloat btnMarginTop = 30;
    
    NSString *conTitle = [self handleStringWithString:_contentStr];
    NSString *Ctitle = [self handleStringWithString2:conTitle];
    CGRect rect  = [Ctitle boundingRectWithSize:CGSizeMake(ScreenWidth - 40, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 12]} context:nil];
    
    CGFloat labelMarginTop = 40;
    
    CGFloat timemarginTop = 60;
    
    _yuchengHight = tiemHeight +btnMarginTop +rect.size.height +labelMarginTop +timemarginTop;
    
    return _yuchengHight;
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
