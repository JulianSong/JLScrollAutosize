//
//  IVTItemTableViewController.m
//  IVTest
//
//  Created by SongJunliang on 15/8/14.
//  Copyright (c) 2015年 SongJunliang. All rights reserved.
//

#import "JLSATableViewController.h"

@implementation JLSATableViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.tableView.bounces = NO;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.contentView.layer.cornerRadius =  8.0f;
        cell.textLabel.text = @"I am hare!";
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.frame = CGRectInset(cell.bounds,5,5);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"ofset y is %f",scrollView.contentOffset.y);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollDelegate scrollViewDidScroll:scrollView];
    }
}
@end
