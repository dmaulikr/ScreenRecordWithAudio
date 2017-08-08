//
//  BlazeiceAudioRecordAndTransCoding.h
//  BlazeiceRecordAloudTeacher
//
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AudioRecorder : NSObject

@property (nonatomic, readonly) BOOL isRecording;

- (BOOL)startRecording;
- (void)stopRecordingWithCompletion:(dispatch_block_t)completionBlock;
@end
