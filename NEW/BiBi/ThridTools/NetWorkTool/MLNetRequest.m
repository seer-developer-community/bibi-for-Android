//
//  MLNetRequest.m
//  AlongChat
//
//  Created by yuanbo on 2017/9/1.
//  Copyright © 2017年 AlongChat. All rights reserved.
//

#import "MLNetRequest.h"
//#import "WXApi.h"
//#import "MLWebViewController.h"
//#import "MLChatTabBarController.h"
//#import "Common.h"
@implementation MLNetRequest

//+(void)loginTXIMWithUid:(NSString *)uid password:(NSString *)password succ:(Success)succ fail:(FailureStr)fail{
//
//    //登录参数
//    IMALoginParam* loginParam = [[IMALoginParam alloc] init];
//
//    [IMAPlatform configWith:loginParam.config];
//    USERDEFAULTS;
//    loginParam.identifier = uid;
//    loginParam.userSig = [userDefault objectForKey:USERSIG];
//    loginParam.appidAt3rd = kSdkAppId;
//    //发起登陆
//
//    [[IMAPlatform sharedInstance] login:loginParam succ:^{
//        [[HUDHelper sharedInstance] syncStopLoadingMessage:@"登录成功"];
//
//        [[IMAPlatform sharedInstance] registNotification];
//        [[IMAPlatform sharedInstance] configOnLoginSucc:loginParam];
//
//
//        if ([MLUserInfoModel sharedManager].nickname.length>0) {
//            TIMFriendProfileOption *option = [[TIMFriendProfileOption alloc] init];
//            TIMUserProfile *profile = [[TIMUserProfile alloc] init];
//            profile.nickname = [MLUserInfoModel sharedManager].nickname;
//            profile.faceURL = [MLUserInfoModel sharedManager].face_url;
//
//            [[TIMFriendshipManager sharedInstance] modifySelfProfile:option profile:profile succ:^{
//                DebugLog(@"设置资料成功");
//
//            } fail:^(int code, NSString *msg) {
//                DebugLog(@"code = %d, err = %@", code, msg);
//
//            }];
//        }
//
//        succ(@"登录成功");
//
//    } fail:^(int code, NSString *msg) {
//        fail(@"登录失败");
//
//    }];
//
//}
//
//+ (void)postValidCodeParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//
//    [[MLNetworkTool sharedManager]postWithMethod:GETVERIFICATIONCODE Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)postLoginParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure {
//
//    NSMutableDictionary *dic=paragmeter.mutableCopy;
//
//    [dic setObject:[Common getDeviceId] forKey:@"device_code"];
//
//    [YBProgressHUD showProgressCircleNoValue:@"正在请求"];
//    [[MLNetworkTool sharedManager]postWithMethod:LOGIN Paragmeter:dic Sucess:^(id responseObject) {
//
//        USERDEFAULTS
//        NSString *uid=[NSString stringWithFormat:@"%@",responseObject[@"result"][@"uid"]];
//        [userDefault setObject:responseObject[@"result"][@"sig"] forKey:USERSIG];
//
//        [[MLUserInfoModel sharedManager] setUserInfoWithDict:responseObject[@"result"]];
//
//        [MLNetRequest loginTXIMWithUid:uid password:uid succ:^(id data) {
//
//            [userDefault setObject:uid forKey:USERID];
//            [userDefault setObject:responseObject[@"result"][@"tokenSecret"] forKey:TOKENSECRET];
//            [userDefault setObject:responseObject[@"result"][@"accessToken"] forKey:ACCESSTOKEN];
//
//            [MLNetRequest postGetUserInfoCodeController:self Sucess:^(id responseObject) {
//
//
//                if (sucessBlock) {
//                    sucessBlock(responseObject);
//                }
//
//            } CodeFailuer:^{
//                [YBProgressHUD showMsgWithoutView:@"请求失败..."];
//                if (codeFailure) {
//                    codeFailure();
//                }
//            }];
//
//        } fail:^(NSString *error) {
//            [YBProgressHUD showMsgWithoutView:@"请求失败..."];
//            if (codeFailure) {
//                codeFailure();
//            }
//        }];
//
//    } Failrue:^(NSError *error) {
//        if (codeFailure) {
//            codeFailure();
//        }
//    }];
//}
//
//+(void)postForgetValidParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:FORGETVALID Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)postForgetChangeParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//
//    [YBProgressHUD showProgressCircleNoValue:@"正在修改...."];
//    [[MLNetworkTool sharedManager]postWithMethod:FORGETCHANGE Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)postUpdateUserInfoParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//
//    [YBProgressHUD showProgressCircleNoValue:@"正在保存..."];
//    [[MLNetworkTool sharedManager]postWithMethod:UPDATEUSERINFO Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
//+ (void)postUpdateUserHederParagmeter:(NSDictionary *)paragmeter userPic:(UIImage *)image Sucess:(Success)sucessBlock {
//
//    [YBProgressHUD showProgressCircleNoValue:@"正在上传..."];
//    [[MLNetworkTool sharedManager]postUpdatePic:UPDATEUSERPIC userPic:image Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)postUserTheLabelSucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:GETTAGS Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)postUserJobsSucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:GETJOBS Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)postGetUserInfoCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure {
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETUSERINFO Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//        if (codeFailure) {
//            codeFailure();
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)postGetUserInfoCodeController:(id)targer Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure {
//    USERDEFAULTS
//    NSString *qd=[[NSBundle mainBundle] infoDictionary][@"qd"];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETUSERINFO Paragmeter:@{@"uid":[userDefault  objectForKey:USERID],@"channel":qd,@"version":@"1"} Sucess:^(id responseObject) {
//
//        MLLog(@"%@",responseObject);
//        [[MLUserInfoModel sharedManager] setUserInfoWithDict:responseObject[@"result"][@"userInfo"]];
//        [[MLUserInfoModel sharedManager] setUserInfoWithDict:responseObject[@"result"][@"accountInfo"]];
//        [[MLUserInfoModel sharedManager] setUserInfoWithDict:responseObject[@"result"][@"levelInfo"]];
//
//        [userDefault setObject:responseObject[@"result"] forKey:USERINFO];
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//        if (codeFailure) {
//            codeFailure();
//        }
//    } Failrue:^(NSError *error) {
//        if ([userDefault objectForKey:USERINFO]) {
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:[userDefault objectForKey:USERINFO][@"userInfo"]];
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:[userDefault objectForKey:USERINFO][@"accountInfo"]];
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:[userDefault objectForKey:USERINFO][@"levelInfo"]];
//            [[MLUserInfoModel sharedManager] setInitUserInfoModel:NO];
//        }
//    }];
//}
//
//+(void)getFanUserListCodeControllerr:(id)targer Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure Failuer:(Failure)Failure{
//    USERDEFAULTS
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETFANUSERLIST Paragmeter:@{@"uid":[userDefault  objectForKey:USERID]} Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//        if (codeFailure) {
//            codeFailure();
//        }
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
//
//+(void)getFollowUserListCodeControllerr:(id)targer Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure Failuer:(Failure)Failure{
//    USERDEFAULTS
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载"];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETFOLLOWUSERLIST Paragmeter:@{@"uid":[userDefault  objectForKey:USERID]} Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//        if (codeFailure) {
//            codeFailure();
//        }
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
//
//+(void)addFollowParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:ADDFOLLOW Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)delFollowParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:DELFOLLOW Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)checkFollowParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:CHECKFOLLOW Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
////获取送礼用户列表
//+ (void)getGiftUserListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETGIFTUSERLIST Paragmeter:@{@"uid":[MLUserInfoModel sharedManager].uid} Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////详情页信息（聊天价格、基本信息）
//+ (void)getUserInfoForDetailPageCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETUSERINFOFORDETAILPAGE Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////查询日消费总榜
//+ (void)getUserPayDayListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETUSERPAYDAYLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//    }];
//}
////查询周消费总榜
//+ (void)getUserPayWeekListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETUSERPAYWEEKLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////查询月消费总榜
//+ (void)getUserPayMonthListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETUSERPAYMONTHLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////查询消费总榜
//+ (void)getUserPayTotalListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETUSERPAYTOTALLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////查询日魅力总榜
//+ (void)getToticketDayListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETTOTICKETDAYLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//    }];
//}
////查询周魅力总榜
//+ (void)getToticketWeekListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETTOTICKETWEEKLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////查询月魅力总榜
//+ (void)getToticketMonthListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETTOTICKETMONTHLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////查询魅力总榜
//+ (void)getToticketAllListCodeController:(id)targer Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETTOTICKETALLLIST Paragmeter:nil Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
//
////推荐列表
//+ (void)getRecommendListCodeController:(id)targer Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    USERDEFAULTS
//
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETRECOMMENDLIST Paragmeter:@{@"uid":[userDefault objectForKey:USERID]} Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//          if (failureBlock) {
//            failureBlock(error);
//        }
//    }];
//}
//
////热门用户列表
//+ (void)getHotRoomListCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETHOTROOMLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////活跃用户列表
//+ (void)getActiveRoomListCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETACTIVEROOMLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
//
//+ (void)getLocalRoomListCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETLOCALROOMLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//    }];
//}
//
////陪聊活跃用户列表
//+ (void)getListWithDynamicUserCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETLISTWITHDYAMICUSER Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
////陪聊最新用户列表
//+ (void)getListWithNewUserCodeController:(id)targer Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithCodeController:targer Method:GETLISTWITHNEWUSER Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//      }];
//}
//
//
//+ (void)getGiftListSucess:(Success)sucessBlock {
//
//    [[MLNetworkTool sharedManager]postWithMethod:GETGIFTLIST Paragmeter:nil Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+ (void)getRechargeTypeStr:(NSString *)typeStr CardList:(Success)sucessBlock{
//
//    [[MLNetworkTool sharedManager]postWithMethod:GETRECHARGECARDLIST Paragmeter:@{@"type":typeStr} Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+ (void)getAdConfigImgSucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETADCONFIGIMG Paragmeter:nil Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+ (void)getApplePrePayParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithMethod:APPLEPAY Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+ (void)getAppleCallbackParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:APPCALLBACK Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//
//    } Failrue:^(NSError *error) {
//      }];
//
//}
//
//+(void)agreeVideoOrAudioParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//
//    [[MLNetworkTool sharedManager]postWithMethod:STARTLIVE Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)requestVideoParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailureWithParameter)codeFailure{
//
//    [[MLNetworkTool sharedManager]postWithMethod:REQUESTLIVE_video Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(id error) {
//
//        if ([error isKindOfClass:[NSDictionary class]]) {
//            if ([error[@"err_code"] intValue]==8013) {
//                if (codeFailure) {
//                    codeFailure(error[@"err_msg"]);
//                }
//
//            }
//        }
//
//    }];
//}
//
//+(void)requestAudioParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailureWithParameter)codeFailure{
//
//    [[MLNetworkTool sharedManager]postWithMethod:REQUESTLIVE_voice Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(id error) {
//        if ([error isKindOfClass:[NSDictionary class]]) {
//            if ([error[@"err_code"] intValue]==8013) {
//                if (codeFailure) {
//                    codeFailure(error[@"err_msg"]);
//                }
//
//            }
//        }
//    }];
//}
//+(void)requestEndChat:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure{
//
//
//    [[MLNetworkTool sharedManager]postWithCodeController:nil Method:ENDCHAT Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } CodeFailuer:^{
//        if (codeFailure) {
//            codeFailure();
//        }
//    } Failrue:^(NSError *error) {
//        if (codeFailure) {
//            codeFailure();
//        }
//      }];
//
//}
//
//+(void)requestRefuseChat:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:REFUSECHAT Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+ (void)requestApprChatParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:LIVEAPPCHAT Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+(void)uWatchT:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure{
//
//    static int i=0;
//
//    [[MLNetworkTool sharedManager]postWithCodeController:nil Method:UWATCHT Paragmeter:paragmeter Sucess:^(id responseObject) {
//        i=0;
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//
//    } CodeFailuer:^{
//        i++;
//
//
//        if (i<3) {
//            [MLNetRequest uWatchT:paragmeter Sucess:sucessBlock CodeFailuer:codeFailure];
//        }else{
//            if (codeFailure) {
//                codeFailure();
//            }
//        }
//
//    } Failrue:^(NSError *error) {
//        i++;
//
//        if (i<3) {
//            [MLNetRequest uWatchT:paragmeter Sucess:sucessBlock CodeFailuer:codeFailure];
//        }else{
//            if (codeFailure) {
//                codeFailure();
//            }
//        }
//    }];
//
//}
//
//+(void)sendGift:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//
//    [[MLNetworkTool sharedManager]postWithMethod:SENDGIFT Paragmeter:paragmeter Sucess:^(id responseObject) {
//
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//      }];
//}
//
//+ (void)searchByKeyParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failuer:(Failure)Failure{
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithMethod:SEARCHBYKEY Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (Failure) {
//            Failure(error);
//        }
//    }];
//}
//
//+ (void)getRechargeListParagmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [YBProgressHUD showProgressCircleNoValue:@"正在加载..."];
//    [[MLNetworkTool sharedManager]postWithMethod:GETRECHARGELIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
//+(void)postHeart:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:POSTHEART Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//
//    }];
//
//}
//+(void)getCallMessageList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//
//    [[MLNetworkTool sharedManager]postWithMethod:GETCALLMESSAGELIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
//
//+(void)getSeeRecord:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//
//    [[MLNetworkTool sharedManager]postWithMethod:SEERECORD Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
//
////获取上传文件token
//+ (void)getFileToken:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:GETFILETOKEN Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////保存上传视频
//+ (void)saveEntity:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:SAVEENTITY Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////获取收费视频列表（根据点赞量倒序排序）
//+ (void)getPrivateVideoList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETPRIVATELIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////获取视频列表（根据点赞量倒序排序）
//+ (void)getVideoList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETVIDEOLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////获取个人中心视频上传列表（根据上传时间倒序排序）
//+ (void)getOwnList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETOWNLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
//// 获取个人关注视频列表（根据点赞量倒序排序）
//+ (void)getFollowList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETFOLLOWLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////删除小视频(逻辑删除)
//+ (void)videoDel:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:VIDEODEL Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////发表评论
//+ (void)publishComment:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:PUBLISHCOMMENT Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////获取该视频评论内容列表(根据评论时间倒序排序)
//+ (void)getComment:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETCOMMENT Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////为视频点赞
//+ (void)likeThis:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:VIDEOLIKETHIS Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////取消点赞
//+ (void)unlike:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:VIDEOUNLIKE Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////分享记录
//+ (void)videoShare:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:VIDEOSHARE Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
//
////访问记录
//+ (void)videoAccess:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:VIDEOACCESS Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
////绑定手机号
//+ (void)bindPhone:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:BINDPHONE Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//
//}
////绑定第三方账号
//+ (void)bindThirdAccount:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:BINDTHIRDACCOUNT Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//
//}
////解绑第三方账号
//+ (void)unbindThird:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:UNBINDTHIRD Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//
//}
//
//+(void)clearCallMessage:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:CLEARCALLMESSAGE Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//
//    }];
//}
//+(void)deleteCallMessage:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:DELETECALLMESSAGE Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//
//    }];
//}
//#pragma mark - 下载礼物图片
//+ (void)downImageWithURL:(NSString *)url PathName:(NSString *)name{
//

//}
//
//+(void)sendMessage:(EMMessage *)aMessage succ:(Success)succ{
//    
//}
//
//+ (void)getPRICES:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:GETPRICES Paragmeter:nil Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
//// 获取现金购买会员方式充值卡列表
//+ (void)getVipCardList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETVIPCARDLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
////获取金币购买会员方式充值卡列表
//+ (void)getCoinVipCardList:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETCOINVIPCARDLIST Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
////金币购买会员支付
//+ (void)getVipCoin:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:VIPCOIN Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
////召唤
//+ (void)pushSms:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:PUSHSMS Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
////收费视频
//+ (void)showVideo:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:SHOWVIDEO Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
////收费视频
//+ (void)showMessageVideo:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:SHOWMESSAGEVIDEO Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
//
//+(void)messageRestrict:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:MESSAGERESTRICT Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(id error) {
//        if ([error isKindOfClass:[NSDictionary class]]) {
//            if ([error[@"err_code"] intValue]==142536) {
//                if (failureBlock) {
//                    failureBlock(error[@"err_msg"]);
//                }
//                
//            }
//        }
//    }];
//}
//
//
//+(void)getLetterState:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETLETTERSTATE Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
//
////发起随机比艺主播聊天
//+ (void)connRequest:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:CONNREQUSET Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(id error) {
//        if ([error isKindOfClass:[NSDictionary class]]) {
//            if ([error[@"err_code"] intValue]==8013) {
//                if (failureBlock) {
//                    failureBlock(error[@"err_msg"]);
//                }
//                
//            }
//        }
//    }];
//}
//
////新注册用户推送小视频
//+ (void)newUser:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock {
//    [[MLNetworkTool sharedManager]postWithMethod:NEWUSERVIDEO Paragmeter:@{@"uid":[MLUserInfoModel sharedManager].uid} Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
//+(void)recommendedAttentionList:(id)parameters succ:(Success)sucessBlock fail:(Failure)fail{
//    [[MLNetworkTool sharedManager]postWithMethod:RECOMMENDATTENTIONLIST Paragmeter:@{@"uid":[MLUserInfoModel sharedManager].uid} Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//+(void)allAttentionRecommended:(id)parameters succ:(Success)succ fail:(Failure)fail{
//    [[MLNetworkTool sharedManager]postWithMethod:BATCHATTENTION Paragmeter:parameters Sucess:^(id responseObject) {
//        if (succ) {
//            succ(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//+(void)getUserIsShowAttentionList:(id)parameters succ:(Success)succ fail:(Failure)fail{
//    [[MLNetworkTool sharedManager]postWithMethod:ISSHOWATTENTIONLIST Paragmeter:@{@"uid":[MLUserInfoModel sharedManager].uid} Sucess:^(id responseObject) {
//        if (succ) {
//            succ(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
////设置发布的视频到主页展示
//+ (void)setToHead:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock {
//    [YBProgressHUD showProgressCircleNoValue:@"正在保存..."];
//    [[MLNetworkTool sharedManager]postWithMethod:SETTOHEADVIDEO Paragmeter:paragmeter Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } Failrue:^(NSError *error) {
//    }];
//}
//
//+(void)exchangeCoin:(id)parameters succ:(Success)sucessBlock fail:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:EXCHANGECOIN Paragmeter:parameters Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock([responseObject objectForKey:@"result"]);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//    
//}
//+(void)getBankInfo:(id)parameters succ:(Success)sucessBlock fail:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:GETBANKINFO Paragmeter:parameters Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock([responseObject objectForKey:@"result"]);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//    
//}
//+(void)setBankInfo:(id)parameters succ:(Success)sucessBlock fail:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:SETBANKINFO Paragmeter:parameters Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock([responseObject objectForKey:@"result"]);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//    
//}
//+(void)withdraw:(id)parameters succ:(Success)sucessBlock fail:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:USERWITHDRAW Paragmeter:parameters Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock([responseObject objectForKey:@"result"]);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
//+(void)accountInList:(id)parameters succ:(Success)sucessBlock fail:(Failure)failureBlock{
//    [[MLNetworkTool sharedManager]postWithMethod:ACCOUNTINLIST Paragmeter:parameters Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock([responseObject objectForKey:@"result"]);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//}
//
//+(void)getDisplayImg:(id)parameters succ:(Success)sucessBlock fail:(Failure)failureBlock{
//    
//    [[MLNetworkTool sharedManager]postWithMethod:GETDISPLAYIMG Paragmeter:parameters Sucess:^(id responseObject) {
//        if (sucessBlock) {
//            sucessBlock([responseObject objectForKey:@"result"]);
//        }
//    } Failrue:^(NSError *error) {
//        if (failureBlock) {
//            failureBlock(nil);
//        }
//    }];
//    
//}
//
//
//
//

@end
