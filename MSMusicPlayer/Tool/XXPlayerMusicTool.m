//
//  XXPlayerMusicTool.m
//  LZXMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import "XXPlayerMusicTool.h"


@interface XXPlayerMusicTool ()

@end

static NSMutableDictionary *players;

@implementation XXPlayerMusicTool

+ (void)initialize
{
    players = [NSMutableDictionary dictionary];
}

+ (AVAudioPlayer *)playerMusicWithName:(NSString *)name
{
    //  根据名字去字典中查找播放器
    AVAudioPlayer *player = players[name];
    
    if (nil == player) {
        // 创建播放器并且存进字典中
        NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:nil];
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        [players setObject:player forKey:name];
    }
    
    [player play];
    return player;
}

+(void)pauseMusicWithName:(NSString *)name
{
    // 根据名字去字典中查找播放器
    
    AVAudioPlayer *player = players[name];
    
    // 找到后执行 暂停操作
    
    if (player) {
        
        [player pause];
    }
}

+ (void)stopMusicWithName:(NSString *)name
{
    // 根据名字去字典中查找播放器
    
    AVAudioPlayer *player = players[name];
    
    // 找到后执行 停止操作
    
    if (player) {
        
        // 想要保存 上次播放记录的  这两句可以不写  直接写[player  stop]
        player.currentTime = 0;
        
        [players setObject:player forKey:name];
        
        [player stop];
    }
}

@end
