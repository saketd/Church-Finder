//
//  MapKitAPIs.h
//  DLBA
//
//  Created by Alok Patil on 03/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <MapKit/MapKit.h>

@interface MapKitAPIs : NSObject {
	
}
+(MKCoordinateRegion)GetMapRegionFromCoordinates:(NSArray*)coordinates;
+(MKCoordinateRegion)GetMapRegionFromSingleCoordinate:(CLLocationCoordinate2D)coordinate;

+(NSMutableDictionary *)getLatitudeLongitude:(NSString*)address;
+(NSString *)getAddressString:(float)latitude:(float)longitude;
@end
