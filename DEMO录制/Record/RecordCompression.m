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
    
    NSURL *audioUrl=[NSURL fileURLWithPath:audioPath];
	NSURL *videoUrl=[NSURL fileURLWithPath:videoPath];
	
	AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audioUrl options:nil];
	AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:videoUrl options:nil];
	
	//混合音乐
	AVMutableComposition* mixComposition = [AVMutableComposition composition];
	AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio 
																						preferredTrackID:kCMPersistentTrackID_Invalid];
	[compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) 
										ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject]
										 atTime:kCMTimeZero error:nil];
	
	
	//混合视频
	AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo 
																				   preferredTrackID:kCMPersistentTrackID_Invalid];
	[compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) 
								   ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] firstObject]
									atTime:kCMTimeZero error:nil];
	AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition 
																		  presetName:AVAssetExportPresetPassthrough];   
	

	//保存混合后的文件的过程
	NSString* videoName = exportFile;
	NSString *exportPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:videoName];
	NSURL    *exportUrl = [NSURL fileURLWithPath:exportPath];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:exportPath]) 
	{
		[[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
	}
	
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
