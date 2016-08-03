//
//  ViewController.m
//  LZXMusicPlayer
//
//  Created by mr.scorpion on 16/6/27.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import "ViewController.h"
#import "XXMusicData.h"
#import "XXTableModel.h"
#import "XXTableViewCell.h"
#import "XXMusicDetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUITableView];
}
- (void)addUITableView
{
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 60;
    [self.view addSubview:table];
    [table registerClass:[XXTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView = table;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [XXMusicData dataArray].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XXTableModel *model = [XXMusicData dataArray][indexPath.row];
    cell.tableModel = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXTableModel *model = [XXMusicData dataArray][indexPath.row];
    [XXMusicData setMusic:model];
    
    XXMusicDetailViewController *view = [[XXMusicDetailViewController alloc]init];
    [self presentViewController:view animated:YES completion:nil];
}
@end
