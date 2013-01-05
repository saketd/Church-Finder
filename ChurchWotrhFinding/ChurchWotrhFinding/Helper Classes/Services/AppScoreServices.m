//
//  AppScoreServices.m
//  BusinessBooking
//
//  Created by .. on 06/06/12.
//  Copyright (c) 2012 JDQAustralia Pty Ltd. All rights reserved.
//

#import "AppScoreServices.h"
#define kNotificationShowMBProgressBar @"showProgress"
#define kNotificationHideMBProgressBar @"hideProgress"

@implementation AppScoreServices
@synthesize strNotificationName;
@synthesize isServiceRunning;


- (id)initWithNotification:(NSString*)kNotificationName
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.strNotificationName = kNotificationName;
        isServiceRunning = NO;
    }
    return self;
}

//this method used to get the data from service , Get Request Handler
-(void)GetHttpRequest:(NSString*)strURL
{
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"networkStatus"])
    {
        
        if (isServiceRunning) {
            return;
        }
        isServiceRunning = YES;
        // The url to make the request to
        NSURL *colorURL = [NSURL URLWithString:strURL];
        //The actual request
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:colorURL];
        request.timeOutSeconds = 12000;
        [request setDelegate:self];
        [request startAsynchronous];
    }
    else
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"No Network",nil)];
    }
}
#pragma Get Method delegates 
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *serverResponseDict = [responseString JSONValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:serverResponseDict];
    serverResponseDict = nil;
    responseString = nil;
    isServiceRunning = NO;
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
	NSLog(@"error %@",error);
   [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:error];
   isServiceRunning = NO;
} 

//This method use to post data to Post Service 
-(void)PostResultUsingHttpRequest:(NSString*)strJson:(NSString *)strUrl
{
    //NSLog(@"strJson %@",strJson);
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"networkStatus"])
    {
        if (isServiceRunning) {
            return;
        }
        isServiceRunning = YES;
        NSURL *url=[NSURL URLWithString:strUrl];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setDelegate:self];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request setRequestMethod:@"POST"];
        [request appendPostData:[strJson dataUsingEncoding:NSUTF8StringEncoding]];
        [request setDidFailSelector:@selector(uploadFailed:)];
        [request setDidFinishSelector:@selector(uploadFinished:)];
        [request startAsynchronous];
    }else 
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"No Network",nil)];
    }    
}
#pragma Post Method delegates 
- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{ 
	NSError *error = [theRequest error];
	NSLog(@"error %@",error);
    [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:error];
    isServiceRunning = NO;
}
- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
	NSString *responseString = [theRequest responseString];
  //  NSLog(@"response %@",responseString);
    NSMutableDictionary *serverResponseDict=[responseString JSONValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:serverResponseDict];
    serverResponseDict = nil;
    responseString = nil;
    isServiceRunning = NO;
}

/************************************************
 Method				:	PostAPIWithParametersDictionary:withURL:withPhoto:
 Purpose			:	This method help to post the data on any url with image 
 Parameters			:	Dictinoay of parameters and Requested URL 
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	02-03-2011
 ************************************************/ 

-(void)PostAPIWithParametersDictionary:(NSMutableDictionary*)dictParameters withURL:(NSString*)strURL 
{	
	if([[NSUserDefaults standardUserDefaults]boolForKey:@"networkStatus"])
    {
        if (isServiceRunning) {
            return;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationShowMBProgressBar object:nil];
        
        isServiceRunning = YES;
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strURL]];
        
        NSArray *arrayKeys = [dictParameters allKeys];
        for (int i=0; i <[arrayKeys count]; i++) {
            [request setPostValue:[dictParameters valueForKey:[arrayKeys objectAtIndex:i]] forKey:[arrayKeys objectAtIndex:i]];
        }
        
        [request setUseCookiePersistence:YES];
        [request setUseSessionPersistence:YES];
        [request setTimeOutSeconds:600];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(uploadNormalFailed:)];
        [request setDidFinishSelector:@selector(uploadNormalFinished:)];
        [request startAsynchronous];
    }else 
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"No Network",nil)];
    }  
}

# pragma PostAPIWithParametersDictionary Method Delegates ASIPostFormat
- (void)uploadNormalFailed:(ASIHTTPRequest *)theRequest
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationHideMBProgressBar object:nil];
    [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"Network Error.",nil)];
	NSError *error = [theRequest error];
	NSLog(@"error %@",error);
    [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:error];
    isServiceRunning = NO;
}
- (void)uploadNormalFinished:(ASIHTTPRequest *)theRequest
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationHideMBProgressBar object:nil];
  	NSString *responseString = [theRequest responseString];
   
    
   // NSLog(@"response %@",responseString);
    NSMutableDictionary *serverResponseDict=[responseString JSONValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:serverResponseDict];
    serverResponseDict = nil;
    responseString = nil;
    isServiceRunning = NO;
}


@end
