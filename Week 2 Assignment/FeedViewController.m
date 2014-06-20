//
//  FeedViewController.m
//  Week 2 Assignment
//
//  Created by Billy Roh on 6/19/14.
//  Copyright (c) 2014 Billy Roh. All rights reserved.
//

#import "FeedViewController.h"
#import <HexColors/HexColor.h>

@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView *composerBarView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)loadFeed;

@end

@implementation FeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // View setup
    self.view.backgroundColor = [UIColor colorWithHexString:@"#D3D6DB"];
    self.scrollView.alpha = 0;
    
    // Scrollview
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 2000);
    
    // Navigation bar - label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"News Feed";
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    // Navigation bar - leftBarItem
    UIImage* imageLeft = [UIImage imageNamed:@"search"];
    CGRect frameLeft = CGRectMake(0, 0, imageLeft.size.width, imageLeft.size.height);
    UIButton *leftButton = [[UIButton alloc] initWithFrame:frameLeft];
    [leftButton setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(nilSymbol)
         forControlEvents:UIControlEventTouchUpInside];
    [leftButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    // Navigation bar - rightBarItem
    UIImage* imageRight = [UIImage imageNamed:@"person"];
    CGRect frameRight = CGRectMake(0, 0, imageRight.size.width, imageRight.size.height);
    UIButton *rightButton = [[UIButton alloc] initWithFrame:frameRight];
    [rightButton setBackgroundImage:imageRight forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(nilSymbol)
         forControlEvents:UIControlEventTouchUpInside];
    [rightButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *rightButtonItem =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    // Indicator
    [self.indicatorView startAnimating];
    [self performSelector:@selector(loadFeed) withObject:nil afterDelay:2];
    
    // Status bar
    [self setNeedsStatusBarAppearanceUpdate];
    
    // TODO
    // add in leftBarItem
    // add in rightBarItem
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFeed
{
    [self.indicatorView stopAnimating];
    self.indicatorView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.alpha = 1;
    }];

    
}

@end
