//
//  BlazeiceAudioRecordAndTransCoding.m
//  BlazeiceRecordAloudTeacher
//
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import "AudioRecorder.h"
#import "RecordPath.h"
#import "AudioToolbox/AudioToolbox.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface AudioRecorder()
@property (retain, nonatomic)   AVAudioRecorder     *recorder;
@property (copy, nonatomic)     NSString            *recordFileName;//录音文件名
@property (copy, nonatomic)     NSString            *recordFilePath;//录音文件路径
@end

@implementation AudioRecorder

#pragma mark - 开始录音
- (void)startRecording{
    
    //设置文件名和录音路径
    _recordFilePath = [RecordPath tempAudioUrlPath];
    //初始化录音
    AVAudioRecorder *temp = [[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:[_recordFilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                       settings:[self getAudioRecorderSettingDict]
                                                          error:nil];
    self.recorder = temp;
    _recorder.meteringEnabled = YES;
    [self.recorder prepareToRecord];
    //开始录音
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self.recorder record];
}


#pragma mark - 录音开始
-(void)startRecord{
    [self.recorder record];
    _isRecording=NO;
}

#pragma mark - 录音暂停
-(void)pauseRecord{
    if (self.recorder.isRecording) {
        [self.recorder pause];
        _isRecording=YES;
    }
}

#pragma mark - 录音结束
- (void)stopRecordingWithCompletion:(dispatch_block_t)completionBlock{
   
    if (self.recorder.isRecording||
        (!self.recorder.isRecording&&_isRecording)) {
        
        [self.recorder stop];
        self.recorder = nil;
    }
}


- (NSDictionary*)getAudioRecorderSettingDict
{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                   nil];
    return recordSetting;
}


@end
