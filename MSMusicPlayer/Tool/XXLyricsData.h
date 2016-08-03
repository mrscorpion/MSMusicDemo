//
//  XXLyricsData.h
//  LZXMusicPlayer
//
//  Created by mr.scorpion on 16/6/29.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XXTableModel;
@interface XXLyricsData : NSObject

@property (nonatomic, strong) XXTableModel  *lrcModel;

+ (NSArray *)lrcs;

+ (instancetype)shareLyrics;

@end
