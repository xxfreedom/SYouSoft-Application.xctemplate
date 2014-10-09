//
//  SYCommonFunction.m
//  SyouInfomationPublish
//
//  Created by sy on 14-4-23.
//  Copyright (c) 2014年 Syousoft. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

@implementation SYCommonFunction
+(BOOL)positionAllowed
{
    CLAuthorizationStatus status= [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusAuthorized:
        {
            return YES;
        }
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            return NO;
        }
        default:
            return NO;
            break;
    }
}
+(BOOL)isPhoneNumber:(NSString *)phoneStr
{
    NSString * regex = @"[1-9][0-9]{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:phoneStr];
}
+(BOOL)isSecurityCode:(NSString *)securityCodeStr
{
    NSString * regex = @"[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:securityCodeStr];
}
+(BOOL)passWordIsAvailable:(NSString *)passWord
{
    NSString * regex = @"^[A-Za-z0-9]{6,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:passWord];
}
+(BOOL)accountDisavailable:(NSString *)account
{
    if (account.length >= 6) {
        return YES;
    }
    return NO;
}
+(BOOL)passWordisavailable:(NSString *)password
{
    if (password.length >= 6 && password.length <= 15) {
        return YES;
    }
    return NO;
}
+(BOOL)mailAddressAvailable:(NSString *)mailAddress
{
    NSString * regex = @"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [pred evaluateWithObject:mailAddress];
}
+(NSComparisonResult)compareAppVersion:(NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [app_build compare:appVersion];
}
+(NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_build;
}
+(BOOL)getMediaIsPermissionFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (sourceType==UIImagePickerControllerSourceTypeCamera)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == AVAuthorizationStatusDenied)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}
+(BOOL)getMediaIsAvailableFromSource:(UIImagePickerControllerSourceType)sourceType
{
    BOOL isAvailable=[UIImagePickerController isSourceTypeAvailable:sourceType];
    return isAvailable;
}
+(BOOL)getAudioIsAvailable
{
       AVAudioSession *session = [AVAudioSession sharedInstance];
        if(session.isInputAvailable)
        {
            return YES;
        }
        else
            return NO;
}
+(BOOL)getAudioIsPermission
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusDenied)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
+(NSString *)convertDistanceWithMete:(int)mete
{
    NSString *distanceStr;
    if(mete/1000<=0)
    {
        distanceStr =[NSString stringWithFormat:@"%dm",mete];
    }
    else
    {
        distanceStr =[NSString stringWithFormat:@"%.1fkm",mete*1.0/1000];
    }
    return distanceStr;
}
+(CGSize)countSubviewsFrameWith:(NSString*)title withWidth:(int)width withFontSize:(int)fontSize
{
    CGSize labelSize;
    if (IOS7)
    {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName,nil];
        labelSize=[title boundingRectWithSize:CGSizeMake(width,FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }
    else
        labelSize = [title sizeWithFont:[UIFont systemFontOfSize:fontSize]
                      constrainedToSize:CGSizeMake(width,FLT_MAX)
                          lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize;
}
+(NSString *)removeRetureKeyWithString:(NSString *)string
{
    NSString *regTags = @"[.\n]+";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionUseUnixLineSeparators error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    NSString *str=string;
    BOOL isFirst=YES;
    NSMutableArray *rangeArr=[NSMutableArray array];
    for (NSTextCheckingResult *match in matches)
    {
        BOOL isSame=NO;
        NSRange matchRange = [match range];
        NSString *tagString = [string substringWithRange:matchRange];
        if (isFirst)
        {
            [rangeArr addObject:tagString];
            isFirst=NO;
        }
        for (NSString *len in rangeArr)
        {
            if ([tagString isEqualToString:len])
            {
                isSame=YES;
            }
        }
        if (!isSame)
        {
            [rangeArr addObject:tagString];
        }
    }
    for (int i=0; i<rangeArr.count; i++)
    {
        NSString *temp=rangeArr[i];
        for (int j=i+1; j<rangeArr.count; j++)
        {
            NSString *tempStr=rangeArr[j];
            if (temp.length<tempStr.length)
            {
                NSString *tempFuck=rangeArr[i];
                rangeArr[i]=tempStr;
                rangeArr[j]=tempFuck;
            }
        }
    }
    for (int i=0; i<rangeArr.count; i++)
    {
        NSString *temp=rangeArr[i];
        str=[str stringByReplacingOccurrencesOfString:temp withString:@" "];
    }
    return str;
}
@end
