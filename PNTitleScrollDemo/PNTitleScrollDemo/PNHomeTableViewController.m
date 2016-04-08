//
//  PNHomeTableViewController.m
//  PNTitleScrollDemo
//
//  Created by lpn on 16/4/8.
//  Copyright © 2016年 lpn. All rights reserved.
//

#import "PNHomeTableViewController.h"

@interface PNHomeTableViewController ()
@end

@implementation PNHomeTableViewController


/// 接收点击的是哪个label
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",self.title,indexPath.row];
    return cell;
}

@end
