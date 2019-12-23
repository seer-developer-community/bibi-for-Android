//
//  UITextView+Placeholder.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "UITextView+Placeholder.h"

@implementation UITextView (Placeholder)

- (void)setPlaceHolder:(NSString *)placeHolder {
    UILabel *placeHolderStr = [[UILabel alloc] init];
    placeHolderStr.text = placeHolder;
    placeHolderStr.numberOfLines = 0;
    placeHolderStr.textColor = [UIColor lightGrayColor];
    [placeHolderStr sizeToFit];
    [self addSubview:placeHolderStr];
    placeHolderStr.font = self.font;
    [self setValue:placeHolderStr forKey:@"_placeholderLabel"];
    
}
@end
