//
//  XXTableViewCell.m
//  LZXMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import "XXTableViewCell.h"
#import "XXTableModel.h"


@interface XXTableViewCell ()

@property (nonatomic, weak) UIImageView  *tableImageView;

@property (nonatomic, weak) UILabel  *tableTitleLabel;

@property (nonatomic, weak) UILabel  *tableNameLabel;

@end

@implementation XXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI
{

    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    self.tableImageView  = imageView;

    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self addSubview:titleLabel];
    self.tableTitleLabel = titleLabel;

    
    UILabel *nameLabel = [[UILabel alloc]init];
    [self addSubview:nameLabel];
    self.tableNameLabel = nameLabel;

}

- (void)layoutSubviews
{
    NSInteger height = self.bounds.size.height;
    NSInteger width = self.bounds.size.width;
    
    self.tableImageView.frame = CGRectMake(5, 5, height - 10, height - 10);
    self.tableTitleLabel.frame = CGRectMake(height , 2, width/2, (height - 10)/2);
    self.tableNameLabel.frame = CGRectMake(height, height/2 - 2, width/2, (height - 10)/2);
    
    self.tableImageView.layer.cornerRadius = 24;
    self.tableImageView.layer.borderWidth = 5;
    self.tableImageView.layer.borderColor = [UIColor purpleColor].CGColor;
    self.tableImageView.clipsToBounds = YES;
}

- (void)setTableModel:(XXTableModel *)tableModel
{
    _tableModel = tableModel;
    self.tableImageView.image = [UIImage imageNamed:tableModel.singerIcon];
    self.tableTitleLabel.text = tableModel.name;
    self.tableNameLabel.text = tableModel.singer;
}
@end
