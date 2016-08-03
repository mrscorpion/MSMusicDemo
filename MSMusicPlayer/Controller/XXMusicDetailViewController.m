//
//  XXMusicDetailViewController.m
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "XXMusicDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XXMusicimgaeView.h"
#import "XXControllerView.h"
#import "XXPlayerMusicTool.h"
#import "XXMusicData.h"
#import "XXTableModel.h"
#import "XXLyricsView.h"
#import "XXCurrentPlayLyricView.h"
#import "XXStringConverTime.h"
#import "XXLockScreenInfo.h"


@interface XXMusicDetailViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, weak) XXMusicimgaeView       *musicImageView;

@property (nonatomic, weak) XXControllerView       *musicController;

@property (nonatomic, weak) XXLyricsView           *lrcView;

@property (nonatomic, weak) XXCurrentPlayLyricView *CurrentPlayLyricView;

@property (nonatomic, strong) AVAudioPlayer        *player;

@property (nonatomic, weak) UILabel                *timeLabel;

@property (nonatomic, weak) UILabel                *titleLabel;

@property (nonatomic, weak) UILabel                *nameLabel;

@property (nonatomic, strong) NSTimer              *timer;

@property (nonatomic, assign) BOOL                 playWithPause;

@property (nonatomic, strong) CADisplayLink        *link;

@end

static XXTableModel  *tableMusicModel;

@implementation XXMusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self currentPlayMusic];
    
}
- (void)currentPlayMusic
{
    // 判断 当前播放的歌曲  和 选中的歌曲是不是同一个
    if (tableMusicModel != [XXMusicData playingMusic]) {
        
        // 停止当前播放的歌曲
        [self stop];
    }
    // 构建界面
    [self addUI];
}
- (void)addUI
{
    [self addMusicImageView];
    [self addMusicControllerView];
    [self addlrcLabel];
    [self addLrcView];
    [self addBackBtn];
    [self play];

}
- (void)addBackBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(5, 10, 50, 50);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark - AddView
- (void)addMusicImageView
{
    XXMusicimgaeView *musicImage = [[XXMusicimgaeView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/3 *2)];
    [self.view addSubview:musicImage];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [musicImage addGestureRecognizer:pan];
    
    self.musicImageView = musicImage;
}

- (void)addMusicControllerView
{
    XXControllerView *musicController = [[XXControllerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/3 * 2, self.view.bounds.size.width, self.view.bounds.size.height/3)];
    [musicController.playOrPause addTarget:self action:@selector(playeOrPauseEvent) forControlEvents:UIControlEventTouchUpInside];
    [musicController.next addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    [musicController.previous addTarget:self action:@selector(previousEvent) forControlEvents:UIControlEventTouchUpInside];
    [musicController.sliderBtn addTarget:self action:@selector(sliderBtnStartEvent:) forControlEvents:UIControlEventTouchDown];
    [musicController.sliderBtn addTarget:self action:@selector(sliderBtnChangeEvent:) forControlEvents:UIControlEventValueChanged];
    [musicController.sliderBtn addTarget:self action:@selector(sliderBtnEndEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:musicController];
    self.musicController = musicController;
}

- (void)addLrcView
{
    XXLyricsView *lrcView = [[XXLyricsView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.musicImageView.bounds.size.width,self.musicImageView.bounds.size.height)];
    [self.view addSubview:lrcView];
    UIPanGestureRecognizer *lrcViewPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(lrcViewPanEvent:)];
    [lrcView addGestureRecognizer:lrcViewPan];
    self.lrcView = lrcView;
}

- (void)addlrcLabel
{
    XXCurrentPlayLyricView *currentPlayLyricView = [[XXCurrentPlayLyricView alloc]initWithFrame:CGRectMake(0, self.musicImageView.bounds.size.height - 70, self.musicImageView.bounds.size.width, 70)];
    [self.view addSubview:currentPlayLyricView];
    self.CurrentPlayLyricView = currentPlayLyricView;
}
#pragma mark - Updata
- (void)setUIAssignment
{
    self.musicImageView.MusicModel = tableMusicModel;
    self.musicController.musicModel = tableMusicModel;

}
#pragma mark - Player
// 播放选中的歌曲
- (void)play
{
    XXTableModel *tableModel = [XXMusicData playingMusic];
    tableMusicModel = tableModel;
    
    AVAudioPlayer *player = [XXPlayerMusicTool playerMusicWithName:tableModel.filename];
    player.delegate = self;
    self.player = player;
    
    //  传递歌词数据
    self.lrcView.playerModel = tableMusicModel;

    
    [self setUIAssignment];
    
    [self addTimer];
    [self addLink];
    
    [self setUpLockScreenInfo];

}
// 停止当前播放的歌曲
- (void)stop
{
    [self removeTimer];
    [self removeLink];
    
    [XXPlayerMusicTool stopMusicWithName:tableMusicModel.filename];
}

#pragma mark - PlayerController
// 开始或暂停
- (void)playeOrPauseEvent
{
    self.playWithPause = !self.playWithPause;
    self.musicController.playOrPause.selected = self.playWithPause;
    if (!self.playWithPause) {
        
        [XXPlayerMusicTool playerMusicWithName:tableMusicModel.filename];
        
        [self addTimer];
        [self addLink];
        
    }else {
        
        [XXPlayerMusicTool pauseMusicWithName:tableMusicModel.filename];
        
        [self removeTimer];
        [self removeLink];
    }
}
// 下一首
- (void)nextEvent
{
    [XXPlayerMusicTool stopMusicWithName:tableMusicModel.filename];
    
    [XXMusicData nextMusic];
    
    [self play];
}
// 上一首
- (void)previousEvent
{
    [XXPlayerMusicTool stopMusicWithName:tableMusicModel.filename];
    
    [XXMusicData previousMusic];
    
    [self play];
    
}

#pragma mark - Timer

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updataEvent:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)updataEvent:(NSTimer *)sender
{
    self.musicController.sliderBtn.value  = [self.player currentTime] / [self.player duration];
    self.musicController.timeLabel.text = [XXStringConverTime timeConverStringDuration:[self.player duration] CurrentTime:[self.player currentTime]];
}

- (void)addLink
{
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateCurrentTime)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeLink
{
    [self.link invalidate];
    self.link = nil;
}

- (void)updateCurrentTime
{
    self.lrcView.currenTime = self.player.currentTime;
    self.CurrentPlayLyricView.currentTime = self.player.currentTime;
}

#pragma mark - SliderEvent

- (void)sliderBtnStartEvent:(UISlider *)sender
{
    [self removeTimer];
}

- (void)sliderBtnChangeEvent:(UISlider *)sender
{
    // 边界处理, 可以不写这个判断
    if (sender.value >= sender.value - 0.01) {
        sender.value = sender.value - 0.01;
    }
    NSTimeInterval currentTime = sender.value *self.player.duration;
    self.player.currentTime = currentTime;
    self.musicController.timeLabel.text = [XXStringConverTime timeConverStringDuration:[self.player duration] CurrentTime:[self.player currentTime]];
}

- (void)sliderBtnEndEvent:(UISlider *)sender
{
    [self addTimer];
}

#pragma mark - AVAudioPlayerDelegate
// 播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self nextEvent];
}
// 开始中断  (接电话之类的事件造成的)
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [self playeOrPauseEvent];
}
// 中断结束
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    [self playeOrPauseEvent];
}

#pragma mark - pan

- (void)pan:(UIPanGestureRecognizer *)sender
{
    [UIView animateWithDuration:2 animations:^{
        self.lrcView.frame = CGRectMake(0, 0, self.musicImageView.bounds.size.width,self.musicImageView.bounds.size.height);
        self.CurrentPlayLyricView.alpha = 0;
    }];
}

- (void)lrcViewPanEvent:(UIPanGestureRecognizer *)sender
{
    [UIView animateWithDuration:2 animations:^{
        self.lrcView.frame = CGRectMake(self.view.bounds.size.width, 0, self.musicImageView.bounds.size.width,self.musicImageView.bounds.size.height);
        self.CurrentPlayLyricView.alpha = 1;
    }];
}

#pragma mark - 设置锁屏信息
- (void)setUpLockScreenInfo
{
    [XXLockScreenInfo setUpLockScreenInfo:self lrcModel:tableMusicModel Player:self.player];
}
#pragma mark  - 设置当前界面为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    
    if (event.subtype == UIEventSubtypeRemoteControlPlay) {
        
        [self playeOrPauseEvent];
    }
    if (event.subtype == UIEventSubtypeRemoteControlPause) {
        
        [self playeOrPauseEvent];
    }
    if (event.subtype == UIEventSubtypeRemoteControlStop) {
        
        [self playeOrPauseEvent];
    }
    if (event.subtype == UIEventSubtypeRemoteControlNextTrack) {
        
        [self nextEvent];
    }
    if (event.subtype == UIEventSubtypeRemoteControlPreviousTrack) {
        
        [self previousEvent];
    }
    
}
- (void)back
{
    // 移除定时器
    [self removeTimer];
    [self removeLink];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
