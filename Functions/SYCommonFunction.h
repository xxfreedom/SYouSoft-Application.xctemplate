//
//  SYCommonFunction.h
//  SyouInfomationPublish
//
//  Created by sy on 14-4-23.
//  Copyright (c) 2014年 Syousoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#define M_FIX_NULL_STRING(_value,_default)  ([_value isEqual:[NSNull null]]||_value==nil)?_default:_value//判断对象是否为空
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 //判断设备版本
#define DOCUMENT   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
@interface SYCommonFunction : NSObject
+(BOOL)positionAllowed;
+(NSComparisonResult)compareAppVersion:(NSString *)appVersion;
+(NSString *)appVersion;
+(NSString *)convertDistanceWithMete:(int)mete;
+(BOOL)getMediaIsAvailableFromSource:(UIImagePickerControllerSourceType)sourceType;
+(BOOL)getMediaIsPermissionFromSource:(UIImagePickerControllerSourceType)sourceType;
+(BOOL)getAudioIsPermission;
+(BOOL)getAudioIsAvailable;
+(BOOL)isSecurityCode:(NSString *)securityCodeStr;
+(BOOL)isPhoneNumber:(NSString *)phoneStr;
+(BOOL)passWordIsAvailable:(NSString *)passWord;
+(BOOL)passWordisavailable:(NSString *)password;
+(BOOL)accountDisavailable:(NSString *)account;
+(BOOL)mailAddressAvailable:(NSString *)mailAddress;
+(CGSize)countSubviewsFrameWith:(NSString*)title withWidth:(int)width withFontSize:(int)fontSize;
+(NSString *)removeRetureKeyWithString:(NSString *)string;
+ (void)shareActivity:(NSDictionary *)shareInfo;
@end
