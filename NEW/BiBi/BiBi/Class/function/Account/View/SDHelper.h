//
//  SDHelper.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDHelper : NSObject


/**
 计算文字长度
 
 @param text 文字
 @param font 字体
 @return 长度
 */
+ (CGFloat )widthForLabel:(NSString *)text fontSize:(CGFloat)font;

/**
 16进制转换 颜色
 
 @param hexColor 颜色
 @return 转换后的颜色
 */
+(UIColor *) getColor:(NSString *)hexColor;
@end

NS_ASSUME_NONNULL_END
