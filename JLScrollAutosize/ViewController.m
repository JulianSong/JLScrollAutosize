//
//  ViewController.m
//  IVTest
//
//  Created by SongJunliang on 15/8/14.
//  Copyright (c) 2015年 SongJunliang. All rights reserved.
//

#import "ViewController.h"
#import "JLSATableViewController.h"
#import "HMSegmentedControl.h"
@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,JLSATableViewControllerScrollDelegate>
@property (nonatomic,strong) UIPageViewController *tablePages;
@property (nonatomic,strong) HMSegmentedControl *segmentBar;

@property (nonatomic,strong) JLSATableViewController *table1;
@property (nonatomic,strong) JLSATableViewController *table2;
@property (nonatomic,strong) JLSATableViewController *table3;

@end

@implementation ViewController
@synthesize segmentBar=_segmentBar;

@synthesize table1 =_table1;
@synthesize table2 =_table2;
@synthesize table3 =_table3;
- (void)viewDidLoad {
    [super viewDidLoad];


    
    
    _segmentBar = [[HMSegmentedControl alloc] init];
    _segmentBar.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    _segmentBar.backgroundColor = [UIColor greenColor];
    _segmentBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_segmentBar setSectionTitles:@[@"热门商家",@"热门优惠",@"我的收藏"]];
    
    
    _tablePages = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _tablePages.dataSource = self;
    _tablePages.delegate   = self;
    
     _table1 = [[JLSATableViewController alloc] init];
    _table1.scrollDelegate = self;

    [_tablePages setViewControllers:@[_table1]
                          direction:UIPageViewControllerNavigationDirectionForward
                           animated:YES
                         completion:^(BOOL finished) {
        
    }];
    
    _tablePages.view.backgroundColor = [UIColor redColor];
    
    [self addChildViewController:_tablePages];
    [_tablePages willMoveToParentViewController:self];
    [self.view addSubview:_tablePages.view];
    
    [_tablePages didMoveToParentViewController:self];
    
    
    [self.view addSubview:_segmentBar];

    __block ViewController * block_self = self;
    [_segmentBar setIndexChangeBlock:^(NSInteger index) {
        JLSATableViewController *icv ;
        
        
        
        
        
        if (index ==0) {
            
            if (!block_self.table1) {
                block_self.table1= [[JLSATableViewController alloc] init];
                block_self.table1.scrollDelegate = block_self;
            }
            
            icv = block_self.table1;
        }else if(index == 1){
            if (!block_self.table2) {
                block_self.table2= [[JLSATableViewController alloc] init];
                block_self.table2.scrollDelegate = block_self;
            }
            
            icv = block_self.table2;
        }else if(index == 2){
            if (!block_self.table3) {
                block_self.table3= [[JLSATableViewController alloc] init];
                block_self.table3.scrollDelegate = block_self;
            }
            icv = block_self.table3;
        }
        
       [block_self.tablePages setViewControllers:@[icv] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
           
       }];
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    if (viewController == self.table2) {
        if (!self.table1) {
            self.table1 = [[JLSATableViewController alloc] init];
            self.table1.scrollDelegate = self;
        }
        return self.table1;
    }
    
    if (viewController == self.table3) {
        if (!self.table2) {
            self.table2 = [[JLSATableViewController alloc] init];
            self.table2.scrollDelegate = self;
        }
        return self.table2;
    }
    return nil;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (viewController == self.table1) {
        if (!self.table2) {
            self.table2 = [[JLSATableViewController alloc] init];
            self.table2.scrollDelegate = self;
        }
        return self.table2;
    }
    
    if (viewController == self.table2) {
        if (!self.table3) {
            self.table3 = [[JLSATableViewController alloc] init];
            self.table3.scrollDelegate = self;
        }
        return self.table3;
    }
    return nil;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSInteger index ;
    if (pageViewController.viewControllers.firstObject == self.table1) {
        index = 0;
    }
    if (pageViewController.viewControllers.firstObject == self.table2) {
        index = 1;
    }
    if (pageViewController.viewControllers.firstObject == self.table3) {
        index = 2;
    }
    [self.segmentBar setSelectedSegmentIndex:index animated:YES];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tablePages.view.frame = CGRectMake(0,200,self.view.bounds.size.width,self.view.bounds.size.height-200);
    self.segmentBar.frame = CGRectMake(0,150,self.view.bounds.size.width,50);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
static CGPoint  lastOffet;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     CGFloat des = scrollView.contentOffset.y - lastOffet.y;
    NSLog(@"des is %f",des);
    if (scrollView.contentOffset.y >=20  && self.segmentBar.frame.origin.y >0 && des > 0) {
        CGRect frame = self.tablePages.view.frame;
        
        CGFloat y = frame.origin.y - des;
        if (y <0 || y > 250 ) {
            NSLog(@"y is %f",y);
            return;
        }
        
        self.tablePages.view.frame = CGRectMake(0,y,frame.size.width, frame.size.height + des);
        
        frame = self.segmentBar.frame;
        
        self.segmentBar.frame = CGRectMake(0,y-50,frame.size.width, frame.size.height);
        scrollView.contentOffset = CGPointMake(0,20);
    }
    
    if (scrollView.contentOffset.y < 0  && self.segmentBar.frame.origin.y <150 && des < 0) {
        CGRect frame = self.tablePages.view.frame;
        
        CGFloat y = frame.origin.y - des;
        if (y <0 || y > 200 ) {
            NSLog(@"y is %f",y);
            return;
        }
        
        self.tablePages.view.frame = CGRectMake(0,y,frame.size.width, frame.size.height + des);
        
        frame = self.segmentBar.frame;
        
        self.segmentBar.frame = CGRectMake(0,y-50,frame.size.width, frame.size.height);
    }
    
    lastOffet = CGPointMake(scrollView.contentOffset.x,scrollView.contentOffset.y);
}

@end
