//
//  Constants.h
//  LoveBomb
//
//  Created by .. on 20/04/12.
//  Copyright (c) 2012 JDQAustralia Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	LISTING_PAGE = 1, 
	SEARCH_PAGE = 2,
    MAP_PAGE = 3,
    FAVORITE_PAGE = 4,
    BUSINESS_DETAIL_PAGE = 5,
    
} PageNames;

typedef enum 
{
    SHOW_CATEGORY_LIST = 1,
    SHOW_BUSINESS_LIST = 2,
    USER_SIGN_IN = 3,
    USER_SIGN_UP = 4,
    USER_FORGOT_PASSWORD=7,
    TAKEAWAY_TIME_SLOT = 5,
    DINE_IN_TIME_SLOT = 6,
}RequestFors;

typedef enum 
{
    CAFES = 1,
    CLUBS_BARS = 3,
    HAIR_DRESSERS = 4,
    RESTAURANTS = 2,
    
}Categories;

 
//server url
#define serviceURL @"http://192.168.0.101/churchworthfinding/webservice/webservice"


#if !defined(MIN)
#define MIN(A,B)((A) < (B) ? (A) : (B))
#endif

#if !defined(MAX)
#define MAX(A,B)((A) > (B) ? (A) : (B))
#endif

#define COLOR_COMPONENT_SCALE_FACTOR 255.0f

#define DEFAULT_TITLE_COLOR [UIColor colorWithRed:16 / COLOR_COMPONENT_SCALE_FACTOR green:30 / COLOR_COMPONENT_SCALE_FACTOR blue:61 / COLOR_COMPONENT_SCALE_FACTOR alpha:1.0f];

#define DEFAULT_SUBTITLE_COLOR [UIColor colorWithRed:42 / COLOR_COMPONENT_SCALE_FACTOR green:81 / COLOR_COMPONENT_SCALE_FACTOR blue:163 / COLOR_COMPONENT_SCALE_FACTOR alpha:1.0f];

@interface Constants : NSObject {
    
}


@end
