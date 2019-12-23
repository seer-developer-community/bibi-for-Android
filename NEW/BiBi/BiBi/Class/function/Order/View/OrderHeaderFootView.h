//
//  OrderHeaderFootView.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/8.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@protocol caseHeaderViewButtonDelegate<NSObject>
-(void)caseHeaderButtontag:(NSInteger)buttonTag;

@end

@interface OrderHeaderFootView : UITableViewHeaderFooterView

@property(nonatomic,weak) id <caseHeaderViewButtonDelegate>delegate;




@end


