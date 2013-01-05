//
//  AppDelegate.h
//  ChurchWotrhFinding
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate>
{
    Reachability*  internetReachable;
    Reachability*  hostReachable;
    MBProgressHUD *HUD;

}

@property (strong, nonatomic) UIWindow *window;
- (void) updateInterfaceWithReachability: (Reachability*) curReach;
@end
