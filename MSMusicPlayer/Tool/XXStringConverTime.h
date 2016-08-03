//
//  XXStringConverTime.h
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/30.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXStringConverTime : NSObject


+ (NSString *)timeConverStringDuration:(NSTimeInterval)duration CurrentTime:(NSTimeInterval)currentTimer;


+ (NSTimeInterval)setUpTimeWithLrcTime:(NSString *)lrcTime;

@end
