//
//  XXLockScreenInfo.m
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/30.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "XXLockScreenInfo.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XXTableModel.h"

@implementation XXLockScreenInfo

+ (void)setUpLockScreenInfo:(UIViewController *)controller lrcModel:(XXTableModel *)lrcModel Player:(AVAudioPlayer *)player
{
    // 创建播放中心
    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
    
    // 所要展示的信息
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    
    // 歌曲名字
    infoDict[MPMediaItemPropertyTitle]    = lrcModel.name;
    
    // 歌手名字
    infoDict[MPMediaItemPropertyArtist]   = lrcModel.singer;
    
    // 插图
    infoDict[MPMediaItemPropertyArtwork]  = [[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:lrcModel.icon]];
    
    // 总时间
    infoDict[MPMediaItemPropertyPlaybackDuration] = @(player.duration);
    
    // 当前播放时间
    infoDict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(player.currentTime);
    
    // 把播放信息放进 播放中心
    [center setNowPlayingInfo:infoDict];
    
    // 设置远程操控
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    // 设为第一响应者
    [controller becomeFirstResponder];
}


@end
