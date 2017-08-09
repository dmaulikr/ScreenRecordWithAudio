//
//  BlazeiceScreenAnd_audioRecordViewController.m
//  BlazeiceScreenAnd_audioRecord
//
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import "ViewController.h"
#import "RecordCompression.h"
#import "RecordPath.h"

@interface ViewController ()
@property(nonatomic,strong) ScreenRecorder *screenRecord;
@property(nonatomic,strong) AudioRecorder  *audioRecord;
@property(nonatomic,copy)   NSString       * opPath;
@end

@implementation ViewController{
    UIButton *button;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 40)];
    [button setTitle:@"开始录制" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.tag = 1;
    [button addTarget:self action:@selector(recordOrStopRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}


-(void)recordOrStopRecord{
    if (button.tag==1) {
        [button setTitle:@"停止录制" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        button.tag = 2;
        [self startRecord];
    }else{
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.tag = 1;
        [button setTitle:@"开始录制" forState:UIControlStateNormal];
        [self stopRecord];
    }
}


- (void)startRecord {

    [self.screenRecord startRecording];
    [self.audioRecord  startRecording];
}


- (void)stopRecord{
    
    [self.screenRecord stopRecordingWithCompletion:^{
        NSLog(@"Finished recording");
    }];
    [self.audioRecord stopRecordingWithCompletion:^{
        
    }];
    [RecordCompression mergeVideo:[RecordPath tempVideoUrlPath] andAudio:[RecordPath tempAudioUrlPath] success:^(NSString * path) {
                
        //音频与视频合并结束，存入相册中
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
            UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    } failure:^(NSError * error) {
        
    }];
}



- (void)video: (NSString *)videoPath didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInfo{
    
    if (error) {
        NSLog(@"---%@",[error localizedDescription]);
    }else{
        NSLog(@"相册写入成功");
    }
}



- (ScreenRecorder *)screenRecord{
    if(!_screenRecord){
        _screenRecord=[[ScreenRecorder alloc] init];
    }
    return _screenRecord;
}

- (AudioRecorder *)audioRecord{
    if(!_audioRecord){
        _audioRecord = [[AudioRecorder alloc]init];
        
    }
    return _audioRecord;
}
@end
