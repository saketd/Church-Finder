//
//  LoginViewController.h
//  ChurchWotrhFinding
//
//  Created by admin on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "StringUtilityClass.h"
#import "AppScoreServices.h"

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtUserId;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtForgotPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmailAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtRegPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtRegConPassword;
@property(nonatomic,readwrite)int requestFor;
@property(nonatomic,strong) AppScoreServices *appscoreservice;
- (IBAction)actionSignIn:(id)sender;
- (IBAction)actionRegister:(id)sender;
- (IBAction)actionForgotPassword:(id)sender;
-(IBAction)actionForgotPasswordSubmit:(id)sender;
-(IBAction)actionregisterDataSubmit:(id)sender;

@end
