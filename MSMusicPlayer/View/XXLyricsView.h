//
//  XXLyricsView.h
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/29.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XXTableModel;
@interface XXLyricsView : UIView

@property (nonatomic, strong) XXTableModel  *playerModel;

@property (nonatomic, assign) NSTimeInterval currenTime;



@end
