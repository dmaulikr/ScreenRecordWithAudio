//
//  THCaptureUtilities.m
//  ScreenCaptureViewTest
//
//  Created by J on 2017/8/8.
//  Copyright © 2017年 Corrine Chan. All rights reserved.
//

#import "RecordCompression.h"

static NSString* const exportFile =  @"exportFile.mov";

@implementation RecordCompression

+ (void)mergeVideo:(NSString *)videoPath andAudio:(NSString *)audioPath
           success:(void(^)(NSString*))success failure:(void(^)(NSError*))failure{
    
   NSFileManager* manager = [NSFileManager defaultManager] ;
    if (![manager fileExistsAtPath:videoPath]||![manager fileExistsAtPath:audioPath])
        return;

    
    NSError* error;
    NSURL *audioUrl=[NSURL fileURLWithPath:audioPath];
	NSURL *videoUrl=[NSURL fileURLWithPath:videoPath];
	
	AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audioUrl options:nil];
    AVMutableComposition* mixComposition = [AVMutableComposition composition];

	//混合音乐
    
	AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio 
																						preferredTrackID:kCMPersistentTrackID_Invalid];
    
    NSArray* audioArray = [audioAsset tracksWithMediaType:AVMediaTypeAudio];
    if(!audioArray.count)NSLog(@"音频有问题");
	[compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) 
										ofTrack:[audioArray firstObject]
										 atTime:kCMTimeZero error:nil];
	
	
    
	//混合视频
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:videoUrl options:nil];
	AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
																				   preferredTrackID:kCMPersistentTrackID_Invalid];
    NSArray* videoArray = [videoAsset tracksWithMediaType:AVMediaTypeVideo];
    if(!videoArray.count)NSLog(@"视频有问题");
	[compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) 
								   ofTrack:[videoArray firstObject]
									atTime:kCMTimeZero error:&error];
    if(error){
        NSLog(@"%@",error.userInfo);
    }
	AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition 
																		  
                                                                      presetName:AVAssetExportPresetHighestQuality];
	

	//保存混合后的文件的过程
	NSString* videoName = exportFile;
	NSString *exportPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:videoName];
	NSURL    *exportUrl = [NSURL fileURLWithPath:exportPath];
	
	if ([manager fileExistsAtPath:exportPath])
	{
		[manager removeItemAtPath:exportPath error:nil];
	}
    
    
    [manager removeItemAtPath:videoPath error:nil];
    [manager removeItemAtPath:audioPath error:nil];

	
	_assetExport.outputFileType = @"com.apple.quicktime-movie";
	NSLog(@"file type %@",_assetExport.outputFileType);
	_assetExport.outputURL = exportUrl;
	_assetExport.shouldOptimizeForNetworkUse = YES;
	
	[_assetExport exportAsynchronouslyWithCompletionHandler:
	 ^(void ) 
    {    
        NSLog(@"完成了");
        
        success(exportPath);
     }];
}

@end
