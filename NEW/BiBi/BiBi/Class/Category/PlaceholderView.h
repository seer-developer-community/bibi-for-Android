//
//  PlaceholderView.h
//  TableViewPlaceholder
//
//  Created by administrator on 2017/8/26.
//
//

#import <UIKit/UIKit.h>
//点击后的回调
typedef void(^TapBlock)();

@interface PlaceholderView : UIView
@property(nonatomic,copy)TapBlock onTapBlock;
/** 代码块内注意对self的循环引用  */
- (instancetype)initWithFrame:(CGRect)frame onTapView:(TapBlock)onTapBlock;
@end
