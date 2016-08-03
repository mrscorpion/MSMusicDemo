//
//  XXLockScreenInfo.h
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/30.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@class XXTableModel;
@class AVAudioPlayer;
@interface XXLockScreenInfo : NSObject

+ (void)setUpLockScreenInfo:(UIViewController *)controller lrcModel:(XXTableModel *)lrcModel Player:(AVAudioPlayer *)player;



@end
