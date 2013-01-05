//
//  UINavigationBar+CustomBackground.m
//  iFlash_Pro
//
//  Created by admin on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+CustomBackground.h"
#define knotificationNavTitleBtnAction @"NavTitleBtn"

@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    
    UIImage *image = [UIImage imageNamed: @"navigation_bg.png"];
    [image drawInRect:CGRectMake(0, 0,320, 44.0)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(actionNavigationBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(110, 10, 100, 30);
    [self addSubview:btn];
    
   // [[UINavigationBar appearance] addSubview:btn];
    
}

-(void)actionNavigationBtn:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:knotificationNavTitleBtnAction object:nil];
}
@end
