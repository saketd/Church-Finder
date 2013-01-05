//
//  LoginViewController.m
//  ChurchWotrhFinding
//
//  Created by admin on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

#import "HomeViewController.h"

#define knotificationUserSignInResponse @"UserSignInResponse"
#define knotificationUserSignUpResponse @"UserSignUpResponse"
#define knotificationUserForgotPasswordResponse @"UserForgotPasswordResponse"

@implementation LoginViewController
@synthesize txtUserId;
@synthesize txtPassword;
@synthesize appscoreservice,requestFor;
@synthesize txtForgotPassword;
@synthesize txtEmailAddress;
@synthesize txtRegPassword;
@synthesize txtRegConPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTxtUserId:nil];
    [self setTxtPassword:nil];
    [self setTxtEmailAddress:nil];
    [self setTxtRegPassword:nil];
    [self setTxtRegConPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)actionRegister:(id)sender {
    LoginViewController *loginViewController=[[LoginViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES]; 
    
}

- (IBAction)actionForgotPassword:(id)sender {
    LoginViewController *loginViewController=[[LoginViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES]; 

}



- (IBAction)actionSignIn:(id)sender {
    
    NSString *strUserId = txtUserId.text;
    strUserId = [StringUtilityClass Trim:strUserId];
    if ([strUserId length] == 0)
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter the Email ID.",nil)];
        return;
    }
    if(![StringUtilityClass validateEmail:strUserId])
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter valid Email ID.",nil)];
        return;
    }
    NSString *strPassword = txtPassword.text;
    strPassword = [StringUtilityClass Trim:strPassword];
    if ([strPassword length] == 0) 
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter Password.",nil)];
        return;
    }
    //allocate the service object 
    appscoreservice = [[AppScoreServices alloc] initWithNotification:knotificationUserSignInResponse];
    //Add a Observer for listing the Location Notification 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSignInResponse:) name:knotificationUserSignInResponse object:nil];
    
    NSMutableDictionary *dictParms = [[NSMutableDictionary alloc] init];
    [dictParms setValue:@"logincheck" forKey:@"method"];
    [dictParms setValue:strUserId forKey:@"email"];
    [dictParms setValue:strPassword forKey:@"password"];
    
    NSMutableDictionary *dictSent = [[NSMutableDictionary alloc] init];
    [dictSent setValue:[dictParms JSONRepresentation] forKey:@"posts"];
    //  NSLog(@"post dict%@",dictSent);
    [appscoreservice PostAPIWithParametersDictionary:dictSent withURL:serviceURL];
     NSLog(@"%@",dictSent);
}



-(void)UserSignInResponse:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:knotificationUserSignInResponse object:nil];

    
    id object = [notification object];
    if ([object isKindOfClass:[NSError class]]) {
        return;
    }
    if ([object isKindOfClass:[NSMutableDictionary class]]) {
        //Manipulate the Dictionary 
        NSLog(@"Dict data %@",object);
        NSDictionary *dict=[object valueForKey:@"result"];
        if([[dict valueForKey:@"logged_in"] intValue]==1 && [[dict valueForKey:@"status"] intValue]==1 )
        {
            HomeViewController *homeViewController=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isSignIn"];

            [self.navigationController pushViewController:homeViewController animated:YES];
             [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"userid"] forKey:@"UserID"];
            return;
        }
        if([[dict valueForKey:@"logged_in"] intValue]==0 && [[dict valueForKey:@"status"] intValue]==0 )
        {
           [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Invalid Email ID and Password.",nil)];
            return;
        }
        else
        {
            [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Login Failed.",nil)];
        }
    }
}



-(IBAction)actionForgotPasswordSubmit:(id)sender
{
    
    NSString *strEmail = txtForgotPassword.text;
    strEmail = [StringUtilityClass Trim:strEmail];
    if ([strEmail length] == 0) {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter the Email ID.",nil)];
        return;
    }
    
    if(![StringUtilityClass validateEmail:strEmail])
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter valid Email ID.",nil)];
        return;
    }
    
    //allocate the service object 
    appscoreservice = [[AppScoreServices alloc] initWithNotification:knotificationUserForgotPasswordResponse];
    //Add a Observer for listing the Location Notification 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserForgotPasswordResponse:) name:knotificationUserForgotPasswordResponse object:nil];
    
    NSMutableDictionary *dictParms = [[NSMutableDictionary alloc] init];
    [dictParms setValue:@"forgotpassword" forKey:@"method"];
    [dictParms setValue:strEmail forKey:@"email"];
   
    NSMutableDictionary *dictSent = [[NSMutableDictionary alloc] init];
    [dictSent setValue:[dictParms JSONRepresentation] forKey:@"posts"];
    //NSLog(@"post dict%@",dictSent);
    [appscoreservice PostAPIWithParametersDictionary:dictSent withURL:serviceURL];
}
-(IBAction)actionregisterDataSubmit:(id)sender
{
    NSString *strEmail = txtEmailAddress.text;
    strEmail = [StringUtilityClass Trim:strEmail];
    if ([strEmail length] == 0) {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter the Email ID.",nil)];
        return;
    }
    
    if(![StringUtilityClass validateEmail:strEmail])
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter valid Email ID.",nil)];
        return;
        
        
    }
    NSString *strPassword = txtRegPassword.text;
    strPassword = [StringUtilityClass Trim:strPassword];
    if ([strPassword length] == 0) {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter password.",nil)];
        return;
    }
    NSString *strConPassword = txtRegConPassword.text;
    strConPassword = [StringUtilityClass Trim:strConPassword];
    if ([strConPassword length] == 0) {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Please enter confirm password.",nil)];
        return;
    }

    
    if(![txtRegPassword.text isEqualToString:txtRegConPassword.text])
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Password and confirm password not match.",nil)];
        return;
        
    }
    
       
    //allocate the service object 
    appscoreservice = [[AppScoreServices alloc] initWithNotification:knotificationUserSignUpResponse];
    //Add a Observer for Response of Near By Business Notification 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSignUpResponse:) name:knotificationUserSignUpResponse object:nil];
    NSMutableDictionary *dictParms = [[NSMutableDictionary alloc] init];
    [dictParms setValue:@"registeruser" forKey:@"method"];
    [dictParms setValue:strEmail forKey:@"email"];
    [dictParms setValue:strPassword forKey:@"password"];
    
    
    NSMutableDictionary *dictSent = [[NSMutableDictionary alloc] init];
    [dictSent setValue:[dictParms JSONRepresentation] forKey:@"posts"];
    [appscoreservice PostAPIWithParametersDictionary:dictSent withURL:serviceURL];
    
   
}

//this method will recive the user Sign up  from service
-(void)UserSignUpResponse:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:knotificationUserSignUpResponse object:nil];
    
    id object = [notification object];
    if ([object isKindOfClass:[NSError class]]) {
        return;
    }
    if ([object isKindOfClass:[NSMutableDictionary class]]) {
        //Manipulate the Dictionary 
        NSLog(@"Dict data %@",object);
        NSDictionary *dict=[object valueForKey:@"result"];
        if([[dict valueForKey:@"register"] intValue]==1)
        {
            [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"User request successfully registered.",nil)];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if([[dict valueForKey:@"register"] intValue]==2)
        {
            [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"User Alredy Exist.",nil)];
            return;
        }
        else
        {
            [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Registration Failed.",nil)];
        }
        
           
    }
}


//this method will recive the user Sign up  from service
-(void)UserForgotPasswordResponse:(NSNotification*)notification
{
       
     [[NSNotificationCenter defaultCenter] removeObserver:self name:knotificationUserForgotPasswordResponse object:nil];
    id object = [notification object];
    
    //NSLog(@"%@",object);
    if ([object isKindOfClass:[NSError class]]) {
        return;
    }
    
    if ([object isKindOfClass:[NSMutableDictionary class]]) {
        //Manipulate the Dictionary 
        NSLog(@"Dict data %@",object);
        NSDictionary *dict=[object valueForKey:@"result"];
        if([[dict valueForKey:@"mailsent"] intValue]==1)
        {
            [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Your Password sent on your Email.",nil)];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if([[dict valueForKey:@"mailsent"] intValue]==2)
        {
             [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Invalid Email.",nil)];
            return;
        }
        else
        {  
            [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Request Failed.",nil)];
        }

        
    }
}

#pragma UITextField Delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if(textField==txtEmailAddress || textField==txtRegPassword || textField== txtRegConPassword)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [self.view setFrame:CGRectMake(0,-50 ,320 ,416 )];
        [UIView commitAnimations];
    }
    
    
    return YES;     
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField==txtUserId)
    {
        [txtPassword becomeFirstResponder];
    }
    if(textField==txtPassword)
    {
        [textField resignFirstResponder];
    }
    
    if(textField==txtForgotPassword)
    {
        [textField resignFirstResponder];
    }
    
    if(textField==txtEmailAddress)
    {
        [txtRegPassword becomeFirstResponder];
        
    }
    if(textField==txtRegPassword)
    {
        [txtRegConPassword becomeFirstResponder];
        
    }
    if(textField==txtRegConPassword)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        [self.view setFrame:CGRectMake(0,0 ,320 ,416 )];
        [UIView commitAnimations];
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
