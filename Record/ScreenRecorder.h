//
//  ASScreenRecorder.h
//  ScreenRecorder
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^VideoCompletionBlock)(void);

@interface ScreenRecorder : NSObject
@property (nonatomic, readonly) BOOL isRecording;

@property (strong, nonatomic) NSURL *videoURL;

+ (instancetype)sharedInstance;
- (BOOL)startRecording;
- (void)stopRecordingWithCompletion:(VideoCompletionBlock)completionBlock;
@end

