//
//  MLNetRequest.h
//  AlongChat
//
//  Created by yuanbo on 2017/9/1.
//  Copyright © 2017年 AlongChat. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <HyphenateLite/EMMessage.h>

typedef void(^FailureStr)(NSString *error);


@interface MLNetRequest : NSObject

////获取验证码
//+ (void)postValidCodeParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////登录
//+ (void)postLoginParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure;
////校验验证码
//+(void)postForgetValidParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////修改密码
//+(void)postForgetChangeParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////更新用户信息
//+ (void)postUpdateUserInfoParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////更新用户头像
//+ (void)postUpdateUserHederParagmeter:(NSDictionary *)paragmeter userPic:(UIImage *)image Sucess:(Success)sucessBlock;
////获取个人标签
//+(void)postUserTheLabelSucess:(Success)sucessBlock;
////获取职业分类
// +(void)postUserJobsSucess:(Success)sucessBlock;
////获取指定用户基础信息
//+ (void)postGetUserInfoCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure;
////获取用户基础信息
//+ (void)postGetUserInfoCodeController:(id)targer Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure;
////获取关注列表
//+ (void)getFollowUserListCodeControllerr:(id)targer Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure Failuer:(Failure)Failure;
////获取粉丝列表
//+ (void)getFanUserListCodeControllerr:(id)targer Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure Failuer:(Failure)Failure;
////添加关注
//+ (void)addFollowParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////取消关注
//+ (void)delFollowParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////是否关注
//+ (void)checkFollowParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////获取送礼用户列表
//+ (void)getGiftUserListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////详情页信息（聊天价格、基本信息）
//+ (void)getUserInfoForDetailPageCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询日消费总榜
//+ (void)getUserPayDayListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询周消费总榜
//+ (void)getUserPayWeekListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询月消费总榜
//+ (void)getUserPayMonthListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询消费总榜
//+ (void)getUserPayTotalListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询日魅力总榜
//+ (void)getToticketDayListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询周魅力总榜
//+ (void)getToticketWeekListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询月魅力总榜
//+ (void)getToticketMonthListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////查询魅力总榜
//+ (void)getToticketAllListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////首页列表
//+ (void)getRecommendListCodeController:(id)targer Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////热门用户列表
//+ (void)getHotRoomListCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////活跃用户列表
//+ (void)getActiveRoomListCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////同城
//+ (void)getLocalRoomListCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////陪聊活跃用户列表
//+ (void)getListWithDynamicUserCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////陪聊最新用户列表
//+ (void)getListWithNewUserCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////礼物列表
//+ (void)getGiftListSucess:(Success)sucessBlock;
////获取充值卡列表
//+ (void)getRechargeTypeStr:(NSString *)typeStr CardList:(Success)sucessBlock;
////轮播图
//+ (void)getAdConfigImgSucess:(Success)sucessBlock;
//
////app支付
//+ (void)getApplePrePayParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////app支付充值完成回调
//+ (void)getAppleCallbackParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////主播同意选择的视频聊天请求
//+ (void)agreeVideoOrAudioParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////向主播发起视频聊天
//+(void)requestVideoParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailureWithParameter)codeFailure;
////向主播发起音频聊天
//+ (void)requestAudioParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailureWithParameter)codeFailure;
////结束聊天
//+ (void)requestEndChat:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure;
////结束聊天评价
//+ (void)requestApprChatParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////拒绝聊天邀请聊天
//+ (void)requestRefuseChat:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////聊天计费
//+ (void)uWatchT:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure;
////送礼物
//+ (void)sendGift:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////陪聊页筛选
//+ (void)searchByKeyParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure;
////获取用户充值列表
//+ (void)getRechargeListParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
//
////查询用户聊天记录
//+ (void)getCallMessageList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
//
////清空用户聊天记录
//+ (void)clearCallMessage:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////删除用户聊天记录
//+ (void)deleteCallMessage:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////心跳
//+ (void)postHeart:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
//
////获取视频,语音价格可选列表
//+ (void)getPRICES:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
//// 获取现金购买会员方式充值卡列表
//+ (void)getVipCardList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////获取金币购买会员方式充值卡列表
//+ (void)getCoinVipCardList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////金币购买会员支付
//+ (void)getVipCoin:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////短信召回
//+ (void)pushSms:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////查看收费视频
//+ (void)showVideo:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////查看消息收费视频
//+ (void)showMessageVideo:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
////访客记录
//+ (void)getSeeRecord:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////获取上传文件token
//+ (void)getFileToken:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////保存上传视频
//+ (void)saveEntity:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////获取视频列表（根据点赞量倒序排序）
//+ (void)getVideoList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////获取收费视频列表（根据点赞量倒序排序）
//+ (void)getPrivateVideoList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////获取个人中心视频上传列表（根据上传时间倒序排序）
//+ (void)getOwnList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
//// 获取个人关注视频列表（根据点赞量倒序排序）
//+ (void)getFollowList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////删除小视频(逻辑删除)
//+ (void)videoDel:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////发表评论
//+ (void)publishComment:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////获取该视频评论内容列表(根据评论时间倒序排序)
//+ (void)getComment:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////为视频点赞
//+ (void)likeThis:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////取消点赞
//+ (void)unlike:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////分享记录
//+ (void)videoShare:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////访问记录
//+ (void)videoAccess:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////绑定手机号
//+ (void)bindPhone:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////绑定第三方账号
//+ (void)bindThirdAccount:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////解绑第三方账号
//+ (void)unbindThird:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////发起随机比艺主播聊天
//+ (void)connRequest:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////新注册用户推送小视频
//+ (void)newUser:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
////登录腾讯im
//+(void)loginTXIMWithUid:(NSString *)uid password:(NSString *)password succ:(Success)succ fail:(FailureStr)fail;
////设置发布的视频到主页展示
//+ (void)setToHead:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
//
//+(void)sendMessage:(EMMessage *)aMessage succ:(Success)succ;
//
//+(void)exchangeCoin:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)getBankInfo:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)setBankInfo:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)withdraw:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)accountInList:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)getDisplayImg:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)recommendedAttentionList:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)allAttentionRecommended:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)getUserIsShowAttentionList:(id)parameters succ:(Success)succ fail:(Failure)fail;
//
//+(void)messageRestrict:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;
//
//+ (void)getLetterState:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock;
//

@end
