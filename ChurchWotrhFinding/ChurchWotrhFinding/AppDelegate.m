//
//  AppDelegate.m
//  ChurchWotrhFinding
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "Reachability.h"
#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"
#define kNotificationShowMBProgressBar @"showProgress"
#define kNotificationHideMBProgressBar @"hideProgress"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   // self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChangedNotification:) name:kReachabilityChangedNotification object:nil];
    internetReachable =[Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    [self updateInterfaceWithReachability: internetReachable];
    
    hostReachable =[Reachability reachabilityWithHostName:@"www.apple.com"];
    [hostReachable startNotifier];
    [self updateInterfaceWithReachability: hostReachable]; 
    
    // notification for show and hide progress view....
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showProgressBar:) name:kNotificationShowMBProgressBar object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideProgressBar:) name:kNotificationHideMBProgressBar object:nil];
    
    RootViewController *rootViewController=[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    
    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:rootViewController];
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    return YES;
}


-(UINavigationController*)GetNavigationControllerOfViewController:(id)object
{
    UINavigationController *navigationcontrol = [[UINavigationController alloc] initWithRootViewController:object];
    return navigationcontrol;
}
- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    
    NetworkStatus internetStatus = [curReach currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable: 
        {
            NSLog(@"The internet is down.");
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"networkStatus"];
        }
            break;
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"networkStatus"];           
        }
            break;
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"networkStatus"];
        }
            break;
    }
    NetworkStatus hostStatus = [curReach currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"networkStatus"];            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"networkStatus"];
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"networkStatus"];
            
            break;
        }
    }
    
    if(internetStatus!=NotReachable)
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"networkStatus"];
        //NSLog(@"cellular");
    }
    
}

- (void)reachabilityChangedNotification: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}

// MBProgress HUD

-(void)showProgressBar:(NSNotification *)notification
{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
	
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD show:YES];
}

-(void)hideProgressBar:(NSNotification *)notification
{
    [HUD hide:YES];
}
#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    
	HUD = nil;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
