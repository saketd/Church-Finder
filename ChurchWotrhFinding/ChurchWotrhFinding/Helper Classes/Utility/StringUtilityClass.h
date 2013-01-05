//
//  StringUtilityClass.h
//  RequestAPI
//
//  Created by Alok Patil on 01-03-2011
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StringUtilityClass : NSObject {

}

//ValidateEmail will check your email string and validate it.
+(BOOL)validateEmail:(NSString*)email;		//default return value NO

//This method used to show Alert With delegete Nil 
+(void)ShowAlertMessageWithHeader:(NSString*)header Message:(NSString*)message;

//this method will retrun the range to Escaped String 
+(NSRange)fromString:(NSString *)inString rangeAfterString:(NSString *)inString  bySkippingNestedOpenTags:(NSString *)openTagStr toStartOfCloseTag:(NSString *)closeTagStr;

//This method will remove the html code from the string and return the non-html string
+(NSString *)removeHTMLStringFromString:(NSString *)html;

//Trim ANy String from front and back
+(NSString*)Trim:(NSString*)value;

//This method will set the Image as Navigation bar 
+(void)SetUINavigationBarStyleWithImage:(NSString*)strImageName;

@end
