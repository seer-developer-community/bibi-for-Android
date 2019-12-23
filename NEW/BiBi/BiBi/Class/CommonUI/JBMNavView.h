//
//  JBMNavView.h
//  JobMarket
//
//  Created by 武建斌 on 2018/5/6.
//  Copyright © 2018年 111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBMNavView : UIView

/**
 导航栏文字标题，和titleImage互斥，只显示一个，title优先
 */
@property (nonatomic, copy)   NSString *title;

/**
 导航栏文字为图片logo，和title互斥，只显示一个
 大小为 (ScreenWidh, 44)
 */
@property (nonatomic, strong) UIImage *titleImage;

/**
 导航栏背景图
 大小为 (ScreenWidh , 44)
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 自定义leftButtonItem
 大小为 (44 , 44)
 */
//@property (nonatomic, strong) FireflyBarButtonItem *leftButtonItem;

/**
 自定义rightButtonItem
 大小为 (44 , 44)
 */
//@property (nonatomic, strong) FireflyBarButtonItem *rightButtonItem;

/**
 自定义closeButtonItem
 大小为 (44,44)
 */
//@property (nonatomic, strong) FireflyBarButtonItem *closeButtonItem;
@property (nonatomic, strong) UIButton *leftBarButton; //大小为 (44 , 44)
@property (nonatomic, strong) UIButton *rightBarButton;//大小为 (44 , 44)
@property(nonatomic,strong)UIImage *lefBarButtonImage;
@property(nonatomic,strong)UIImage *rightBarButtonImage;
@end
