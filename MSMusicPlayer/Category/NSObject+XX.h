//
//  NSObject+XX.h
//  mr.scorpionMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XX)

- (void)initWithDict:(NSDictionary *)dict;

+ (void)modelDataWithDict:(NSDictionary *)dict;

+ (NSArray *)modelWithFileName:(NSString *)name;


@end
