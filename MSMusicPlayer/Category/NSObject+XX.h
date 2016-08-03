//
//  NSObject+XX.h
//  LZXMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XX)

- (void)initWithDict:(NSDictionary *)dict;

+ (void)modelDataWithDict:(NSDictionary *)dict;

+ (NSArray *)modelWithFileName:(NSString *)name;


@end
