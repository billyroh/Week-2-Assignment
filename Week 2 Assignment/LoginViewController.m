//
//  LoginViewController.m
//  Week 2 Assignment
//
//  Created by Billy Roh on 6/18/14.
//  Copyright (c) 2014 Billy Roh. All rights reserved.
//

#import "LoginViewController.h"
#import <HexColors/HexColor.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailInputField;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIView *formWrapperView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *signUpLabel;
@property float formWrapperViewYCoordinate;
@property float signUpLabelYCoordinate;

- (IBAction)onPasswordInputFieldEdit:(id)sender;
- (IBAction)onEmailInputFieldEdit:(id)sender;

- (IBAction)onLogInButtonTap:(id)sender;
- (IBAction)onViewTap:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

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
    if ([self.passwordInputField.text isEqualToString:@""] && [self.emailInputField.text isEqualToString:@""]) {
//        self.logInButton.userInteractionEnabled = NO;
//        self.logInButton.layer.opacity = 0.5;
    }
    
    // Coordinate assignment
    self.formWrapperViewYCoordinate = self.formWrapperView.frame.origin.y;
    self.signUpLabelYCoordinate = self.signUpLabel.frame.origin.y;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPasswordInputFieldEdit:(id)sender {
    if (self.emailInputField.text.length > 0 && self.passwordInputField.text.length > 0) {
        self.logInButton.userInteractionEnabled = YES;
        self.logInButton.layer.opacity = 1;
    } else {
        self.logInButton.userInteractionEnabled = NO;
        self.logInButton.layer.opacity = 0.5;
    }
}

- (IBAction)onEmailInputFieldEdit:(id)sender {
    if (self.emailInputField.text.length > 0 && self.passwordInputField.text.length > 0) {
        self.logInButton.userInteractionEnabled = YES;
        self.logInButton.layer.opacity = 1;
    } else {
        self.logInButton.userInteractionEnabled = NO;
        self.logInButton.layer.opacity = 0.5;
    }
}

- (IBAction)onLogInButtonTap:(id)sender {
    NSLog(@"hello");
    if (self.emailInputField.text.length > 0 && [self.passwordInputField.text isEqualToString:@"password"]) {
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
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

@end
