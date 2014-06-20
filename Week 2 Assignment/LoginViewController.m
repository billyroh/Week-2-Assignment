//
//  LoginViewController.m
//  Week 2 Assignment
//
//  Created by Billy Roh on 6/18/14.
//  Copyright (c) 2014 Billy Roh. All rights reserved.
//

#import "LoginViewController.h"
#import "FeedViewController.h"
#import "RequestsViewController.h"
#import "MessagesViewController.h"
#import "NotificationsViewController.h"
#import "MoreViewController.h"
#import <HexColors/HexColor.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailInputField;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIView *formWrapperView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *signUpLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property float formWrapperViewYCoordinate;
@property float signUpLabelYCoordinate;

- (IBAction)onEmailChange:(id)sender;
- (IBAction)onPasswordChange:(id)sender;
- (IBAction)onLogInButtonTap:(id)sender;
- (IBAction)onViewTap:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

- (void)checkPassword;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Text field setup
    self.passwordInputField.secureTextEntry = YES;
    
    // Button setup
    self.logInButton.userInteractionEnabled = NO;
    self.logInButton.layer.opacity = 0.5;
    [self.indicatorView stopAnimating];
    
    // Coordinate assignment
    self.formWrapperViewYCoordinate = self.formWrapperView.frame.origin.y;
    self.signUpLabelYCoordinate = self.signUpLabel.frame.origin.y;
    
    // Status bar
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEmailChange:(id)sender {
    if (self.emailInputField.text.length > 0 && self.passwordInputField.text.length > 0) {
        self.logInButton.userInteractionEnabled = YES;
        self.logInButton.layer.opacity = 1;
    } else {
        self.logInButton.userInteractionEnabled = NO;
        self.logInButton.layer.opacity = 0.5;
    }
}

- (IBAction)onPasswordChange:(id)sender {
    if (self.emailInputField.text.length > 0 && self.passwordInputField.text.length > 0) {
        self.logInButton.userInteractionEnabled = YES;
        self.logInButton.layer.opacity = 1;
    } else {
        self.logInButton.userInteractionEnabled = NO;
        self.logInButton.layer.opacity = 0.5;
    }
}

- (IBAction)onLogInButtonTap:(id)sender {
    self.logInButton.titleLabel.text = @"Logging In";
    [self.indicatorView startAnimating];
    [self performSelector:@selector(checkPassword) withObject:nil afterDelay:2];
}

- (IBAction)onViewTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move form
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.formWrapperView.frame = CGRectMake(self.formWrapperView.frame.origin.x, (self.view.frame.size.height / 1.05) - keyboardSize.height - self.formWrapperView.frame.size.height, self.formWrapperView.frame.size.width, self.formWrapperView.frame.size.height);
                     }
                     completion:nil];
    
    // Move CTA
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.signUpLabel.frame = CGRectMake(self.signUpLabel.frame.origin.x, (self.view.frame.size.height / 1.04) - keyboardSize.height - self.signUpLabel.frame.size.height, self.signUpLabel.frame.size.width, self.signUpLabel.frame.size.height);
                     }
                     completion:nil];
    
    
}

- (void)willHideKeyboard:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
//    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move form
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.formWrapperView.frame = CGRectMake(self.formWrapperView.frame.origin.x, self.formWrapperViewYCoordinate, self.formWrapperView.frame.size.width, self.formWrapperView.frame.size.height);
                     }
                     completion:nil];
    
    // Move CTA
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.signUpLabel.frame = CGRectMake(self.signUpLabel.frame.origin.x, self.signUpLabelYCoordinate, self.signUpLabel.frame.size.width, self.signUpLabel.frame.size.height);
                     }
                     completion:nil];
    
}

- (void)checkPassword {
    [self.indicatorView stopAnimating];
    if (self.emailInputField.text.length > 0 && [self.passwordInputField.text isEqualToString:@"password"]) {
        
        FeedViewController *feedViewController = [[FeedViewController alloc] init];
        feedViewController.title = @"News Feed";
        UINavigationController *feedNavigationController = [[UINavigationController alloc] initWithRootViewController:feedViewController];
        feedNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:(66.0f/255.0f) green:(98.0f/255.0f) blue:(163.0f/255.0f) alpha:1.0f];
        feedNavigationController.navigationBar.translucent = NO;
        feedNavigationController.tabBarItem.image = [UIImage imageNamed:@"feed-1"];
        
        RequestsViewController *requestViewController = [[RequestsViewController alloc] init];
        requestViewController.title = @"Requests";
        requestViewController.tabBarItem.image = [UIImage imageNamed:@"friends"];
        
        MessagesViewController *messagesViewController = [[MessagesViewController alloc] init];
        messagesViewController.title = @"Messages";
        messagesViewController.tabBarItem.image = [UIImage imageNamed:@"messages"];
        
        NotificationsViewController *notificationViewController = [[NotificationsViewController alloc] init];
        notificationViewController.title = @"Notifications";
        notificationViewController.tabBarItem.image = [UIImage imageNamed:@"notifications"];
        
        MoreViewController *moreViewController = [[MoreViewController alloc] init];
        moreViewController.title = @"More";
        UINavigationController *moreNavigationController = [[UINavigationController alloc] initWithRootViewController:moreViewController];
        moreNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:(66.0f/255.0f) green:(98.0f/255.0f) blue:(163.0f/255.0f) alpha:1.0f];
        moreNavigationController.navigationBar.translucent = NO;
        moreViewController.tabBarItem.image = [UIImage imageNamed:@"more"];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = @[feedNavigationController, requestViewController, messagesViewController, notificationViewController, moreNavigationController];
        
        [self presentViewController:tabBarController animated:YES completion:nil];
        self.logInButton.titleLabel.text = @"Log In";
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        self.logInButton.titleLabel.text = @"Log In";
    }
}

@end
