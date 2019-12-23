//
//  PredictTableView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "PredictTableView.h"

#import "PredictHeaderView.h"
//#import "PredictHeaderModel.h"
#import "DetailsModel.h"
#define itemHeight 20
@implementation PredictTableView
{
    NSInteger itemNum;
}

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
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableprdModel) {
        
        return self.tableprdModel.choseButcount.count;
    }
    else if (self.orderM) {
        
        return self.orderM.choseButcount.count;
    }
   
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PredictTableViewCell *cell =[PredictTableViewCell cellWithTableView:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (self.tableprdModel) {
        if ([self.tableprdModel.proportion[indexPath.row] intValue] == 0&& [self.tableprdModel.awards[indexPath.row] intValue] == 0) {
              cell.odds_numberLabel.text = @"(x0.0)";
            if (self.tableprdModel.room_type == 0) {
                cell.odds_numberLabel.hidden = YES;
                cell.promptBnt.hidden = YES;
            }
        }else{
            if (self.tableprdModel.room_type == 1) {
             cell.odds_numberLabel.text =[NSString stringWithFormat:@"(x%.2f)",self.tableprdModel.total_shares / [self.tableprdModel.proportion[indexPath.row] floatValue]];
//                "ADVpeilv" = "此赔率是以当前参与预测的比例计算的，派奖赔率是以预测截止时参与预测的比例计算";
//                "PVDpeilv" = "此赔率是以当前参与预测的比例计算的，派奖赔率是以预测截止时参与预测的比例计算";
//                "ADVpeilv" = "赔率是参与预测的实际赔率，预测成功后的奖金将以此赔率计算";
                cell.textLabel1.text =NSLocalizedStringFromTable(@"PVDpeilv",@"Internation", nil);
            }
            if (self.tableprdModel.room_type == 2) {
                
                cell.odds_numberLabel.text = [NSString stringWithFormat:@"(x%.2f)",[self.tableprdModel.awards[indexPath.row]floatValue]/10000];
                cell.textLabel1.text =NSLocalizedStringFromTable(@"ADVpeilv",@"Internation", nil);
            }
            
        }
        cell.touLabel.text = self.tableprdModel.choseButcount[indexPath.row];
        
       
       
       
        
    } else if (self.orderM){
        
         cell.touLabel.text = self.orderM.choseButcount[indexPath.row];
        if ([self.orderM.proportion[indexPath.row] intValue]==0&&[self.orderM.awards[indexPath.row] intValue] == 0) {
            cell.odds_numberLabel.text = @"(x0.0)";
            if (self.orderM.room_type == 0) {
                cell.odds_numberLabel.hidden = YES;
                cell.promptBnt.hidden = YES;
                
            }
        }else{
            if (self.orderM.room_type == 1) {
                
                cell.odds_numberLabel.text =[NSString stringWithFormat:@"(x%.2f)",self.orderM.total_shares / [self.orderM.proportion[indexPath.row] floatValue]];
                
//                cell.textLabel1.text =@"此赔率是以当前参与预测的比例计算的，派奖赔率是以预测截止时参与预测的比例计算";
                 cell.textLabel1.text =NSLocalizedStringFromTable(@"PVDpeilv",@"Internation", nil);
            }
            if (self.orderM.room_type == 2) {
                
                cell.odds_numberLabel.text = [NSString stringWithFormat:@"(x%.2f)",[self.orderM.awards[indexPath.row]floatValue]/10000];
//                cell.textLabel1.text =@"赔率是参与预测的实际赔率，预测成功后的奖金将以此赔率计算";
                cell.textLabel1.text =NSLocalizedStringFromTable(@"ADVpeilv",@"Internation", nil);
            }
            
        }
        
        
        
        if (self.orderM.winnerLabel) {
            
            cell.yuceBnt.hidden = YES;
            cell.selected = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.userInteractionEnabled =NO;
            if (indexPath.row == [self.orderM.winnerLabel integerValue]) {
                cell.sureBntImageView.hidden = NO;
                cell.touLabel.textColor = UIColorFromHexValue(0x2C85E2);
            }
        }

        NSComparisonResult result9 = [self.orderM.timeStop compare:[self getCurrentTimes]];
        if (result9 == NSOrderedAscending) {
            cell.yuceBnt.hidden = YES;
            cell.selected = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        


    }
    
    
    
    return cell;
    
 
}

//- (void)setTableprdModel:(PredictHeaderModel *)tableprdModel {
//    _tableprdModel = tableprdModel;
//    itemNum = _tableprdModel.choseButcount.count;
//
//}


//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ([self.sd_delegate respondsToSelector:@selector(SDChatTableView:didSelectRowAtIndexPath:)]) {
//
//        [self.sd_delegate SDChatTableView:self didSelectRowAtIndexPath:indexPath];
//    }
//}

//button 点击
-(void)buttonPush:(UITableViewCell *)cell{

     NSIndexPath *indexPath = [self indexPathForCell:cell];

    if ([self.sd_delegate respondsToSelector:@selector(SDChatTableView:didSelectRowAtIndexPath:)]) {

        [self.sd_delegate SDChatTableView:self didSelectRowAtIndexPath:indexPath];
    }


}

//
//
//
//#pragma mark ----------UITabelViewDelegate----------
//
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PredictHeaderView *headerView = [[PredictHeaderView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    if (self.tableprdModel) {
       headerView.headPredicModel = self.tableprdModel;
    }else if (self.orderM){
        
        headerView.headOrderModel = self.orderM;
    }
    
    
    
//    headerView.headPredicModel.hightw = 0;

    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.tableprdModel) {
        
         return self.tableprdModel.hightH ;
    }else if (self.orderM){
        
        return  self.orderM.hightH;
    }
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
}




-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}



@end
