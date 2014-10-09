//
//  NSObject+isBaseType.h
//  LogMessage
//
//  Created by sy on 8/27/14.
//  Copyright (c) 2014 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
@interface NSObject (isBaseType)
+(BOOL)isBaseType:(id)object;
+(NSDictionary *)getProperty:(id)object;
@end
