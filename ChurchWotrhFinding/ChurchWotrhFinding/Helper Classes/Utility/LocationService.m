//
//  LocationService.m
//  BusinessBooking
//
//  Created by .. on 06/06/12.
//  Copyright (c) 2012 JDQAustralia Pty Ltd. All rights reserved.
//

#import "LocationService.h"
#import "StringUtilityClass.h"

@implementation LocationService
@synthesize locationManager;
@synthesize strNotificationName;
@synthesize isLocationUpdated;

- (id)initWithNotification:(NSString*)kNotificationName
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kDistanceFilter;
        self.strNotificationName = kNotificationName;
        isLocationUpdated = NO;
    }
    return self;
}
//Start the location service 
-(void)startGettingLocation
{
    if ([CLLocationManager locationServicesEnabled]) 
    {
        [self.locationManager startUpdatingLocation];
    }else
    {
        [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"No Location",nil)];
    }
}
#pragma mark - location delegates

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation 
{
    if (isLocationUpdated) {
        return;
    }
    // invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    //[self.locationManager stopUpdatingLocation];
    [manager stopUpdatingLocation];
    isLocationUpdated = YES;
    CLLocation *currentLocation = newLocation;
    [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:currentLocation];
}

// TODO: handle error case
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error 
{
    NSLog(@"error:%@", error.localizedDescription);
     [StringUtilityClass ShowAlertMessageWithHeader:NSLocalizedString(@"Alert",nil) Message:NSLocalizedString(@"No Location",nil)];
    [[NSNotificationCenter defaultCenter] postNotificationName:strNotificationName object:error];
    isLocationUpdated = NO;
    
}

@end
