//
//  QYNetworkManger.h
//  QY
//
//  Created by lxd on 2017/2/20.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(id responseObject);
typedef void (^Failed)(NSError * error);

@interface QYNetworkManger : NSObject

///**
// * 获取商城链接
// */
//+ (void)getMallLink:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 同意入队
// */
//+ (void)agreeJointeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 消息列表
// */
//+ (void)messageList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//    
///**
// * 回复
// */
//+ (void)sendComment_and_replyUser:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 评论详情(回复列表)
// */
//+ (void)commentReplyList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 资讯详情
// */
//+ (void)info_Detail:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 资讯列表
// */
//+ (void)info_List:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 删除评论
// */
//+ (void)deletecomment:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 回复评论
// */
//+ (void)recomment:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 评论列表
// */
//+ (void)commentList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 视频详情
// */
//+ (void)videoDetail:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 视频列表
// */
//+ (void)videoList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
/**
 *获得球队球员
 */
+(void)queryPlayByTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 * 登录接口
 */
+ (void)startLogin:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 * 登出接口
 */
+ (void)loginOut:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 获取大区球队
 */
+ (void)getTeamInfoByZone:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 获取地区球队
 */
+ (void)getTeamInfoByProvence:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

///**
// * 获取验证码
// */
//+ (void)getVerificationCode:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 用户注册
// */
//+ (void)passworldRelated:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed;
//
//
///**
// * 头像上传
// */
//+ (void)uploadThumbnailWithImage:(UIImage *)image method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 球员认证信息
// */
//+ (void)saveApproveInfo:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 球员认证信息
// */
//+ (void)getPlayerInfoResponseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 创建球队
// */
//+ (void)createTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 搜索球队
// */
//+ (void)searchTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取我的球队信息
// */
//+ (void)getMyTeamResponseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 删除球队成员
// */
//+ (void)deletePlayer:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 查询球队信息
// */
//+ (void)selectTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 反馈信息
// */
//+ (void)feedBack:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 咨询获取
// */
//+ (void)getNews:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 咨询获取
// */
//+ (void)joinTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 咨询轮播图信息
// */
//+ (void)getCarousel:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取比赛列表
// */
//+ (void)getRaceList:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取比赛城市
// */
//+ (void)getRaceCity:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed;
//
//
//
///**
// * 获取比赛数据
// */
//+ (void)getRaceData:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取直播信息
// */
//+ (void)getLiveInfoResponseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 创建直播信息
// */
//+ (void)createLive:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取我的比赛列表
// */
//+ (void)getMeRaceList:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取个人直播列表
// */
//+ (void)getMeLiveListResponseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 邀请好友加入球队
// */
//+ (void)inviteFriends:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取频道列表
// */
//+ (void)getChannelList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取视频列表
// */
//+ (void)getChannelVideoList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取频道详情
// */
//+ (void)getChannelDetails:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 保存点赞数
// */
//+ (void)saveThumbs:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 获取商城订单地址
// */
//+ (void)getOrderUrlResponseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 咨询轮播图信息
// */
//+ (void)getVersionInfoResponseSuccess:(Success)success responseFailed:(Failed)failed;
//
///**
// * 修改用户名
// */
//+ (void)changeName:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

@end
