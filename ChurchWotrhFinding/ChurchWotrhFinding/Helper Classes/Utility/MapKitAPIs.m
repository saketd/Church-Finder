//
//  MapKitAPIs.m
//  Request APIs
//
//  Created by Alok Patil on 03/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapKitAPIs.h"


@implementation MapKitAPIs

/************************************************
 Method				:	GetMapRegionFromCoordinates:
 Purpose			:	This method will return the google map region on multiple coordinates basis
 Parameters			:	array of Coordinates  
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	03-03-2011
 ************************************************/ 

+(MKCoordinateRegion)GetMapRegionFromCoordinates:(NSArray*)coordinates {
	
	CLLocationCoordinate2D maxCoord = {-90.0f, -180.0f};
	CLLocationCoordinate2D minCoord = {90.0f, 180.0f};
	for(CLLocation *value in coordinates) {
		CLLocationCoordinate2D coord = {0.0f, 0.0f};
		//[value getValue:&coord];
        Float64 lat = value.coordinate.latitude;
    	Float64 lng = value.coordinate.longitude;
        coord.latitude=lat;
        coord.longitude=lng;
       
		if(coord.longitude > maxCoord.longitude) {
			maxCoord.longitude = coord.longitude;
		}
		if(coord.latitude > maxCoord.latitude) {
			maxCoord.latitude = coord.latitude;
		}
		if(coord.longitude < minCoord.longitude) {
			minCoord.longitude = coord.longitude;
		}
		if(coord.latitude < minCoord.latitude) {
			minCoord.latitude = coord.latitude;
		}
	}
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center.longitude = (minCoord.longitude + maxCoord.longitude) / 2.0;
	region.center.latitude = (minCoord.latitude + maxCoord.latitude) / 2.0;
	region.span.longitudeDelta = (maxCoord.longitude - minCoord.longitude) + 0.001;
	region.span.latitudeDelta = (maxCoord.latitude - minCoord.latitude) + 0.001;
	//[self.mapView setRegion:region animated:YES];
	return region;
}

/************************************************
 Method				:	GetMapRegionFromSingleCoordinate:withURL:
 Purpose			:	This method will return the google map region of a single coordinate 
 Parameters			:	one coordinate object
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	03-03-2011
 ************************************************/ 

+(MKCoordinateRegion)GetMapRegionFromSingleCoordinate:(CLLocationCoordinate2D)coordinate {
	
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center.longitude = coordinate.longitude;
	region.center.latitude = coordinate.latitude;
	region.span.longitudeDelta = 0.005f;
	region.span.latitudeDelta = 0.005f;
	//[self.mapView setRegion:region animated:YES];
	return region;
}

/************************************************
 Method				:	GetLatLng:withAddress:
 Purpose			:	This method will return the lat lng coordinate 
 Parameters			:	one Address object
 Return Value		:	dictionary
 Modified By		:	Dilip Patidar
 Modified On		:	30-06-2012
 ************************************************/ 

+(NSMutableDictionary *)getLatitudeLongitude:(NSString*)address
{
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", 
                           [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
        [dict setValue:[listItems objectAtIndex:2] forKey:@"lat"];
        [dict setValue:[listItems objectAtIndex:3] forKey:@"lng"];
        
	}
    return dict;
    
    
}

/************************************************
 Method				:	GetAddressByLatLng:withLat:withLng
 Purpose			:	This method will return the address 
 Parameters			:	one Address object
 Return Value		:	string
 Modified By		:	Dilip Patidar
 Modified On		:	30-06-2012
 ************************************************/ 

+(NSString *)getAddressString:(float)latitude:(float)longitude
{
    NSError *error;
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latitude,longitude];
    NSString* locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] encoding:NSASCIIStringEncoding error:&error];  
    
    NSMutableDictionary *dict=[locationString JSONValue];   
    NSString *str=@"";
    if([[dict valueForKey:@"status"] isEqualToString:@"OK"])
    {
        //if successful
        //get first element as array
        NSMutableArray *firstResultAddress = [[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"address_components"];	
        
        for(int i=0; i<[firstResultAddress count];i++)
        {
            NSMutableDictionary *dict=[firstResultAddress objectAtIndex:i];
            if (i==0)
            {  
                
                str=[str stringByAppendingFormat:[dict objectForKey:@"long_name"]];
            }
            else
            {
                str=[str stringByAppendingFormat:@",%@",[dict objectForKey:@"long_name"]];
            }           
            
        }
        
        
    }
    return str;
    
}


@end
