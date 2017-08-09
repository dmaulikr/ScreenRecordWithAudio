//
//  RecordPath.m
//  Coordinate
//
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import "RecordPath.h"

@implementation RecordPath
+ (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type{

    NSString* file = [NSString stringWithFormat:@"tmp/%@.%@",_fileName,_type];
    NSString *outputPath = [NSHomeDirectory() stringByAppendingPathComponent:file];
    return outputPath;
}


+ (NSString*)tempVideoUrlPath{
    
     NSString *outputPath = [RecordPath getPathByFileName:@"screenCapture" ofType:@"mp4"];
    return outputPath;
}

+ (NSString*)tempAudioUrlPath{
    return [RecordPath getPathByFileName:AUDIOPATH ofType:@"wav"];
}
@end
