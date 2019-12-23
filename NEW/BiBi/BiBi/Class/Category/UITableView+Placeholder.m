//
//  UITableView+Placeholder.m
//  TableViewPlaceholder
//
//  Created by administrator on 2017/8/26.
//
//

#import "UITableView+Placeholder.h"
#import <objc/runtime.h>

@implementation UITableView (Placeholder)

+ (void)load
{
    //交换刷新方法
    Method reloadData =class_getInstanceMethod(self,  @selector(reloadData));
    Method real_ReloadData =class_getInstanceMethod(self, @selector(real_ReloadData));
    method_exchangeImplementations(reloadData, real_ReloadData);
}

-(void)real_ReloadData
{
    [self dataIsEmpty];
    [self real_ReloadData];
}

/** 判断是否有数据源，没有数据源则显示占位图片  */
- (void)dataIsEmpty
{
    BOOL isEmpty = YES;
    id<UITableViewDataSource> dataSourse = self.dataSource;
    //检测是否有数据源
    if ([dataSourse respondsToSelector:@selector(numberOfSectionsInTableView:)]) {//group
        NSInteger sections = [dataSourse numberOfSectionsInTableView:self];
        if (sections >0) {
            isEmpty = NO;
        }
    }else if([dataSourse respondsToSelector:@selector(tableView:numberOfRowsInSection:)]){//plain
        NSInteger rows = [dataSourse tableView:self numberOfRowsInSection:0];
        if (rows >0) {
            isEmpty = NO;
        }
    }
    if (isEmpty) {//显示占位图
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }else{//移除占位图片
        [self.placeHolderView removeFromSuperview];
    }
}
- (void)setPlaceHolderView:(UIView *)placeHolderView
{
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView
{
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}
@end
