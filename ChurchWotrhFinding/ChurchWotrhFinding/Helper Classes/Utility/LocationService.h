//
//  LocationService.h
//  BusinessBooking
//
//  Created by .. on 06/06/12.
//  Copyright (c) 2012 JDQAustralia Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

static NSInteger const kDistanceFilter;

@interface LocationService : NSObject <CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,retain)NSString *strNotificationName;
@property(nonatomic,readwrite)BOOL isLocationUpdated;
//this init method will initialise the class with notificaiton response 
- (id)initWithNotification:(NSString*)kNotificationName;
//Start the location service 
-(void)startGettingLocation;

@end
