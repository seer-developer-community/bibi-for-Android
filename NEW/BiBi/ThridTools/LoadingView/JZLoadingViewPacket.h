

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Loading_suffix,
    Success_suffix,
    Faild_suffix,
} RequestResult;

@interface JZLoadingViewPacket : UIView


- (void)showWithTitle:(NSString *)title result:(RequestResult)result hasAnimation:(BOOL)animation;



+ (JZLoadingViewPacket *)shareInstance;

+ (void)showWithTitle:(NSString *)title result:(RequestResult)result hasAnimation:(BOOL)animation addToView:(UIView *)selfView;

@end
