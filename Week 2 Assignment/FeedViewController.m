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
    
    [self.indicatorView startAnimating];
    [self performSelector:@selector(loadFeed) withObject:nil afterDelay:2];
    
    // TODO
    // add in leftBarItem
    // add in rightBarItem
    // icons for tabbar
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
