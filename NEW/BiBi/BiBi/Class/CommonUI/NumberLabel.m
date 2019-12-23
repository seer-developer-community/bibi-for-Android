//
//  NumberLabel.m
//  BiBi
//
//  Created by 武建斌 on 2019/2/24.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "NumberLabel.h"

@implementation NumberLabel

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.text =NSLocalizedStringFromTable(@"NO Date",@"Internation", nil);
        self.font = [UIFont systemFontOfSize:18];
        self.textColor = [UIColor blackColor];
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
