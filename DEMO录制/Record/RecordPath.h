//
//  RecordPath.h
//  Coordinate
//
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AUDIOPATH @"audioPath"

@interface RecordPath : NSObject
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type;

+ (NSString*)tempVideoUrlPath;
+ (NSString*)tempAudioUrlPath;

@end
