//
//  THCaptureUtilities.h
//  ScreenCaptureViewTest
//
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>

@interface RecordCompression : NSObject

+ (void)mergeVideo:(NSString *)videoPath andAudio:(NSString *)audioPath
success:(void(^)(NSString*))success failure:(void(^)(NSError*))failure;
@end
