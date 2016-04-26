//
//  NSString+Addtions.h
//  ZYLeibieTest
//
//  Created by wxg on 13-7-11.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addtions) 

-(NSString *)trim;

-(BOOL)isContainFromString:(NSString *)aString;

+(NSString *)getFilepath:(NSString *)aPath;

+(NSString *)getFilePathWithDirectory:(NSString *)aDirectory fileName:(NSString *)aFileName;

- (NSString *)md5WithString;

@end


