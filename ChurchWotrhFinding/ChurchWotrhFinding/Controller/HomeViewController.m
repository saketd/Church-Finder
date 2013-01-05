//
//  HomeViewController.m
//  ChurchWotrhFinding
//
//  Created by admin on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

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
    
    UIButton *buttonBack =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonBack setFrame:CGRectMake(0, 0, 38, 30)];
   [buttonBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpOutside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = backBtn;
    // Do any additional setup after loading the view from its nib.
}
-(void)back:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isSignIn"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
