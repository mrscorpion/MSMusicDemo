//
//  XXMusicData.m
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "XXMusicData.h"
#import "NSObject+XX.h"
#import "XXTableModel.h"

static NSArray *dataArray;
static XXTableModel *tableModel;
@implementation XXMusicData

+ (void)initialize
{
    dataArray = [XXTableModel modelWithFileName:@"Musics.plist"];
}

+ (NSArray *)dataArray
{
    return dataArray;
}

+ (void)nextMusic
{
    //2.找当前模型的下一个模型
    //2.1当前模型的角标
    
    NSUInteger index = [dataArray indexOfObject:tableModel];
    
    //2.2取出上一个
    
    //先判断位置
    
    if (index < dataArray.count - 1) {
        
        index  += 1 ;
        
    }else{
        
        index = 0;
        
    }
    
    XXTableModel *tableData = dataArray[index];
    
    tableModel = tableData;
}

+ (void)previousMusic
{
    NSUInteger index = [dataArray indexOfObject:tableModel];
    
    if (index == 0) {
        
        index = dataArray.count - 1;
        
    } else {
        
        index -= 1;
    }
    
    XXTableModel *tableData = dataArray[index];
    
    tableModel = tableData;
}

+ (void)setMusic:(XXTableModel *)music
{
    tableModel = music;
}

+ (XXTableModel *)playingMusic
{
    return tableModel;
}

@end
