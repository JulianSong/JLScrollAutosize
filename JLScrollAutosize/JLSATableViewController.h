//
//  IVTItemTableViewController.h
//  IVTest
//
//  Created by SongJunliang on 15/8/14.
//  Copyright (c) 2015年 SongJunliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JLSATableViewControllerScrollDelegate<UIScrollViewDelegate>;

@end

@interface JLSATableViewController : UITableViewController
@property(nonatomic,assign)id<JLSATableViewControllerScrollDelegate>scrollDelegate;
@end
