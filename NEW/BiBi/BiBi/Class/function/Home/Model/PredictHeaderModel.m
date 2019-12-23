//
//  PredictHeaderModel.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/28.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "PredictHeaderModel.h"

@implementation PredictHeaderModel

-(CGFloat)hight{
//    if (_hight) {
//        
//        return _hight;
//    }
    
    _hight = 0;
    CGFloat tiemHeight = 50.0;
    CGFloat btnMarginTop = 20;
    CGFloat countitleTop = 20;
    CGFloat chooseBnt = 30 * self.choseButcount.count;
    CGFloat toolMarginTop = 20;
    CGFloat toolHeight = 30;

    CGRect rect  = [_title boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size: 12]} context:nil];
    NSLog(@"caclutare ---%f---%@",rect.size.height,_title);
    _hight = tiemHeight + btnMarginTop +rect.size.height +countitleTop +chooseBnt +toolMarginTop +toolHeight;
    NSLog(@"higt-----%f",_hight);
    
    return _hight;
}

@end
