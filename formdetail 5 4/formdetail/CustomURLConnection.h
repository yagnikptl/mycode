//
//  CustomURLConnection.h
//  CustomURLConnection
//
//  Created by Abbacus on 01/07/14.
//  Copyright (c) 2014 Abbacus. All rights reserved.
//

// API Urls
//------------
//#define API_DomainBase                  @"http://sharetime.on-linedemo.com"
//#define API_DomainBase                  @"http://www.the-timeshare.com"
#define API_DomainBase                  @"http://mobileapi.the-timeshare.com"

//#define API_ChatBase                    API_DomainBase @"/userChat.asmx"
//#define API_ChatImageBase               API_DomainBase @"/userChat.ashx"
//#define API_ChatSessionBase             API_DomainBase @"/userChat.asmx"
#define API_ChatBase                    API_DomainBase @"/userChatV1.asmx"
#define API_ChatImageBase               API_DomainBase @"/userChatV1.asmx"
#define API_ChatSessionBase             API_DomainBase @"/userChatV1.asmx"
#define API_ChatImageUploadBase         API_DomainBase @"/uploadPic.ashx"

//#define API_Base                        API_DomainBase @"/Commonwebservice.asmx/"
//#define API_BaseUserURL                 API_DomainBase @"/CommonWebService.asmx?"
#define API_Base                        API_DomainBase @"/CommonWebService.asmx/"
#define API_BaseUserURL                 API_DomainBase @"/CommonWebService.asmx?"

#define API_BaseURLFormPostImageProfile API_DomainBase @"/UpdateProfilePic.ashx"
#define API_BaseURLFormPostProfile      API_DomainBase @"/setUserDetails.ashx"

#define API_InternetCheck               API_Base @"CheckInternet"
#define API_VersionCheck                API_Base @"CheckAppVersion"
#define API_ServerAvailabityCheck       API_Base @"CheckServerAvailabity"
#define API_CrashReport                 API_Base @"addCrashReport"
#define API_UpdateUserDeviceToken       API_Base @"updateUserToken"
#define API_Logout                      API_Base @"logout"

#define API_ContryList                  API_Base @"getCountryList"
#define API_StateList                   API_Base @"getStateList"
#define API_CityList                    API_Base @"getCityList"

#define API_Login                       API_Base @"APILoginVerification"
#define API_Register                    API_Base @"APIRegistration"
#define API_EditProfilePic              API_BaseURLFormPostImageProfile
#define API_EditProfile                 API_BaseURLFormPostProfile
#define API_ForgotPassword              API_Base @"APIForgotPassword"

#define API_SearchActivityByLocation    API_Base @"searchActivity"
//#define API_ShareActivity               API_Base @"postActivity"
//#define API_ShareActivity               API_DomainBase @"/ActivityPost.ashx"
#define API_ShareActivity               API_DomainBase @"/ActivityPostV1.ashx"
#define API_ShareActivityUserList       API_Base @"shareActivity"

#define API_LifeShareList               API_Base @"MyLifeShare"
//#define API_ChatList                    API_Base @"myChatList"
#define API_ChatList                    API_Base @"myChatListV1"
#define API_ChatDetails                 API_Base @"myChatDetail"

//#define API_CreateChatSession           API_Base @"userChatMessage"
//#define API_ChatConversation            API_Base @"userChatMessage"
//#define API_ChatMessage                 API_Base @"userChatMessage"
#define API_CreateChatSession           API_Base @"userChatMessageV1"
#define API_ChatConversation            API_Base @"userChatMessageV1"
#define API_ChatMessage                 API_Base @"userChatMessageV1"
#define API_ChatImage                   API_ChatImageBase
#define API_ChatImageUpload             API_ChatImageUploadBase
#define API_LoadMoreForChat             API_Base @"userChatPaging"

#define API_FriendList                  API_Base @"getFriendList"
#define API_FriendProfile               API_Base @"viewFriendProfile"
#define API_FriendRequestList           API_Base @"getFriendList"
#define API_FriendRequestSend           API_Base @"sendRequest"
#define API_FriendRequestAcceptDecline  API_Base @"AcceptOrDeclineRequest"

#define API_DeleteChatMessages          API_Base @"deleteChatMessage"
#define API_DeleteUserActivity          API_Base @"deleteActivity"
#define API_DeleteFriend                API_Base @"deletefriend"

#define API_ReportUser                  API_Base @"userReport"

#define API_NotificationList            API_Base @"GetallNotification"
#define API_DeleteNotification          API_Base @"deleteNotification"

#define API_CommentList                 API_Base @"getCommentList"
#define API_PostComment                 API_Base @"addComment"

#define API_CMSPage                     API_Base @"getContent"

#define ID_CMSHelp                      @"1"
#define ID_CMSPrivacypolicy             @"2"
#define ID_CMSTermsAndconditions        @"3"


// API tags
//------------

#define TAG_DomainBase                  101
#define TAG_Base                        102

#define TAG_InternetCheck               103
#define TAG_VersionCheck                104
#define TAG_ServerAvailabityCheck       105
#define TAG_CrashReport                 106
#define TAG_UpdateUserDeviceToken       107
#define TAG_Logout                      108
#define TAG_VersionCheck_BGtoFG         109

#define TAG_ContryList                  111
#define TAG_StateList                   112
#define TAG_CityList                    113

#define TAG_Login                       121
#define TAG_Register                    122
#define TAG_EditProfile                 123
#define TAG_ForgotPassword              124

#define TAG_SearchActivityByLocation    125
#define TAG_ShareActivity               126
#define TAG_ShareActivityUserList       127

#define TAG_LifeShareList               128
#define TAG_ChatList                    129
#define TAG_ChatDetails                 130

#define TAG_CreateChatSession           131
#define TAG_ChatConversation            132
#define TAG_ChatMessage                 133
#define TAG_ChatImage                   134
#define TAG_ChatImageUpload             135
#define TAG_LoadMoreForChat             136

#define TAG_FriendList                  137
#define TAG_FriendProfile               138
#define TAG_FriendRequestList           139
#define TAG_FriendRequestSend           140
#define TAG_FriendRequestAcceptDecline  141

#define TAG_DeleteChatMessages          142
#define TAG_DeleteUserActivity          143
#define TAG_DeleteFriend                144

#define TAG_ReportUser                  145

#define TAG_NotificationList            146
#define TAG_DeleteNotification          147

#define TAG_CommentList                 148
#define TAG_PostComment                 149

#define TAG_CMSPage                     301



#import <Foundation/Foundation.h>
//#import "Global.h"

@protocol CustomURLConnectionDelegate;

@interface CustomURLConnection : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    //Data
    NSMutableData *receivedData;
    
    //Connection
    NSURLConnection *urlConnection;
    
    //tag
    NSInteger tag;
    
    NSString *chatObjectId;

    NSObject *senderObj;
    
    BOOL isFirst;
    
    long long _totalFileSize;
    long long _receivedDataBytes;
}

//Delegate for Protocol
@property(nonatomic, unsafe_unretained) id<CustomURLConnectionDelegate> delegate;
@property(nonatomic,strong)NSObject *senderObj;
@property(nonatomic)NSInteger tag;

//Init Method
-(CustomURLConnection *)initURLConnectionWithRequest:(NSURLRequest *)request withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate withTag:(NSInteger)apiTag andLoader:(BOOL)loader;

-(CustomURLConnection *)initURLConnectionWithRequest:(NSURLRequest *)request withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate withTag:(NSInteger)apiTag withRefObj:(NSObject *)obj andLoader:(BOOL)loader;

-(CustomURLConnection *)initURLConnectionWithRequest:(NSURLRequest *)request withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate withTag:(NSInteger)apiTag withChatMessageId:(NSString *)chatMessageId andLoader:(BOOL)loader;

-(CustomURLConnection *)initURLConnectionWithURL:(NSURL *)url withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate andParameters:(NSDictionary *)paramDic andTag:(NSInteger)Ctag andLoader:(BOOL)loader;

-(CustomURLConnection *)initWithURLByPost:(NSString *)url PostString:(NSString *)postString withMethod:(NSString *)method withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate isPostJson:(BOOL)isJson withTag:(int)apiTag withLoader:(BOOL)loader;

-(CustomURLConnection *)initWithURLByPost:(NSString *)url PostString:(NSString *)postString withMethod:(NSString *)method withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate isPostJson:(BOOL)isJson withTag:(int)apiTag withChatMessageId:(NSString *)chatMessageId withLoader:(BOOL)loader;

@end

//Protocol
@protocol CustomURLConnectionDelegate <NSObject>
@optional
-(void)requestFinished:(CustomURLConnection *)request withResult:(NSDictionary *)dictionary withTag:(NSInteger)apiTag;
-(void)requestFinished:(CustomURLConnection *)request withResult:(NSDictionary *)dictionary withTag:(NSInteger)apiTag withObj:(NSObject *)obj;
-(void)requestFinished:(CustomURLConnection *)request withResult:(NSDictionary *)dictionary withTag:(NSInteger)apiTag withChatMessageId:(NSString *)chatMessageId;

-(void)bytesReturn:(float)returnBytes expectedTotalBytes:(float)totalBytes withTag:(int)progressTag;
@required
-(void)requestFailed:(CustomURLConnection *)request withError:(NSString *)error withTag:(NSInteger)apiTag;
@end
