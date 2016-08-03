//
//  XXPlayerMusicTool.h
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



@interface XXPlayerMusicTool : NSObject
// 播放
+ (AVAudioPlayer *)playerMusicWithName:(NSString *)name;
// 暂停
+ (void)pauseMusicWithName:(NSString *)name;
// 停止
+ (void)stopMusicWithName:(NSString *)name;

@end
