//
//  UIConfig.h
//  JobMarket
//
//  Created by 武建斌 on 2018/5/6.
//  Copyright © 2018年 111. All rights reserved.
//

#ifndef UIConfig_h
#define UIConfig_h

#define UIColorFromHexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBAValue(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define VIEWCONTROLLERBACKGROUNDCOLOR UIColorFromHexValue(0xf5f7fb)

#define FireflyCGRectMake(w,h,x,y) CGRectMake(((w)-(x))/2, ((h)-(y))/2, (x), (y) )

#define IS_SCREEN_55_INCH    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242/2, 2208/2), [[UIScreen mainScreen] bounds].size) : NO)
#define IS_SCREEN_47_INCH    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750/2, 1334/2), [[UIScreen mainScreen] bounds].size) : NO)
#define IS_SCREEN_4_INCH    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640/2, 1136/2), [[UIScreen mainScreen] bounds].size) : NO)
#define IS_SCREEN_35_INCH    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640/2, 960/2),  [[UIScreen mainScreen] bounds].size) : NO)

#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.width >= 375 && [UIScreen mainScreen].bounds.size.height >= 812)
#define STATUS_GAP (IS_iPhoneX? 44 : 20)

#define iPhoneXSafeBottomMargin (IS_iPhoneX ? 34.f : 0.f)

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  (IOS7_OR_LATER? [UIScreen mainScreen].bounds.size.height:([UIScreen mainScreen].bounds.size.height - STATUS_GAP))


#define NAV_BAR_HEIGHT 44
#define NAV_BAR_FRAME (IOS7_OR_LATER? CGRectMake(0, 0, ScreenWidth, NAV_BAR_HEIGHT + STATUS_GAP):CGRectMake(0, 0, ScreenWidth, NAV_BAR_HEIGHT))

#define TOOLBAR_BASICHEIGHT 48
#define TOOLBAR_HEIGHT (TOOLBAR_BASICHEIGHT + iPhoneXSafeBottomMargin)
#define SCROLLVIEW_GAP 20


#define IOS11_OR_LATER      ( [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS10_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS9_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS8_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS7_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS6_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS5_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS4_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"4.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS3_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"3.0" options:NSNumericSearch] != NSOrderedAscending )

#define IOS10_OR_EARLIER    ( !IOS11_OR_LATER )
#define IOS8_OR_EARLIER        ( !IOS9_OR_LATER )
#define IOS7_OR_EARLIER        ( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER        ( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER        ( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER        ( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER        ( !IOS4_OR_LATER )

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kScaleW     [UIScreen mainScreen].bounds.size.width  / 375
#define kScaleH     ([UIScreen mainScreen].bounds.size.height == 812.0 ? 667.0/667.0 : [UIScreen mainScreen].bounds.size.height /667.0)

#define kWidthScale   [UIScreen mainScreen].bounds.size.width / 375

#define kHeightScale ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 667.0/667.0 : [UIScreen mainScreen].bounds.size.height /667.0)
#endif /* UIConfig_h */
