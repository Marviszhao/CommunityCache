//
//  NSString+Addtions.m
//  ZYLeibieTest
//
//  Created by wxg on 13-7-11.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "NSString+Addtions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Addtions)

-(NSString *)trim
{
	
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(BOOL)isContainFromString:(NSString *)aString
{
	
	BOOL flag = [self rangeOfString:aString].location != NSNotFound;
	
	return flag;
}

+(NSString *)getFilepath:(NSString *)aPath
{
	return [NSHomeDirectory() stringByAppendingPathComponent:aPath];	
}

+(NSString *)getFilePathWithDirectory:(NSString *)aDirectory fileName:(NSString *)aFileName
{
	
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:aDirectory];
	NSFileManager *manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:path]) {
		[manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	return [path stringByAppendingPathComponent:aFileName];
	
}

- (NSString *)md5WithString{
    const char *ptr = [self UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X",md5Buffer[i]];
    
    return output;
}

@end
