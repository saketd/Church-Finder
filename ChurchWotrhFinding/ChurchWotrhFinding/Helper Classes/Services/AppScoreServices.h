//
//  AppScoreServices.h
//  BusinessBooking
//
//  Created by .. on 06/06/12.
//  Copyright (c) 2012 JDQAustralia Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "StringUtilityClass.h"
#import "ASIFormDataRequest.h"

@interface AppScoreServices : NSObject

@property(nonatomic,retain)NSString *strNotificationName;
@property(nonatomic,readwrite)BOOL isServiceRunning;

//This init method will initialise the class with notification name
- (id)initWithNotification:(NSString*)kNotificationName;

//this method used to get the data from service , Get Request Handler
-(void)GetHttpRequest:(NSString*)strURL;

//This method use to post data to Post Service 
-(void)PostResultUsingHttpRequest:(NSString*)strJson:(NSString *)strUrl;

-(void)PostAPIWithParametersDictionary:(NSMutableDictionary*)dictParameters withURL:(NSString*)strURL ;

@end
