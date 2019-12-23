//
//  MineTableView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "MineTableView.h"

@implementation MineTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
}
#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }else{
        
          return  [self.dataArray count];
        
    }
    
    
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    JBMChatTableViewCell *cell =[JBMChatTableViewCell cellWithTableView:self];
//    YSChatUserModel *chatUserModel  =self.dataArray[indexPath.row];
//    [cell setValueWithYSChatUserModel:chatUserModel];
    
//    MineTableViewCell *cell = [MineTableViewCell cellWithTableView:self];
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.sd_delegate respondsToSelector:@selector(SDChatTableView:didSelectRowAtIndexPath:)]) {
        [self.sd_delegate SDChatTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark ----------UITabelViewDelegate----------


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



@end
