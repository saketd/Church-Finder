//
//  StringUtilityClass.m
//  RequestAPI
//
//  Created by Alok Patil on 01-03-2011
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StringUtilityClass.h"
#import <UIKit/UIKit.h>

@implementation StringUtilityClass

/************************************************
 Method				:	validateEmail
 Purpose			:	Email Validation
 Parameters			:	None
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	01-03-2011
 Default			:	NO
 ************************************************/ 
+(BOOL)validateEmail:(NSString*)email  
{  
	if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )  
	{ 	
		NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];  
		[invalidCharSet removeCharactersInString:@"_-"];  
		NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];  
		NSString *usernamePart = [email substringToIndex:range1.location];  
		NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];  
		for (NSString *string in stringsArray1) 
		{	NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];  
			if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
				return NO;  
		}  
		NSString *domainPart = [email substringFromIndex:range1.location+1];  
		NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];  
		for (NSString *string in stringsArray2) 
		{	NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];  
			if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])  
				return NO;  
		}  
		return YES;
	}else 
        return NO;  
}



/************************************************
 Method				:	ShowAlertMessageWithHeader
 Purpose			:	Showing Message in Alert With out Any Delegates 
 Parameters			:	Header title and Message 
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	01-03-2011
 Default			:	NO
 ************************************************/ 
+(void)ShowAlertMessageWithHeader:(NSString*)header Message:(NSString*)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:header message:message
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	//NSMutableArray *buttonArray = [alert valueForKey:@"_buttons"];
	[alert show];
	//[[buttonArray objectAtIndex:0] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	//[alert release];
}


/************************************************
 Method				:	Trim
 Purpose			:	Trim ANy String from front and back   
 Parameters			:	restult String
 Return Value		:	String
 Modified By		:	Alok Patil
 Modified On		:	012-05-2012
 Default			:	NO
 ************************************************/ 
+(NSString*)Trim:(NSString*)value
{
	value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return value;
}



/************************************************
 Method				:	convertToXMLEntities
 Purpose			:	This method avoid to send the & Operator in XML  
 Parameters			:	String  
 Return Value		:	String 
 Modified By		:	Alok Patil
 Modified On		:	01-03-2011
 Default			:	NO
 ************************************************/ 
-(NSString*)convertToXMLEntities:(NSString *) myString 
{
    NSMutableString * temp = [myString mutableCopy];
	
    [temp replaceOccurrencesOfString:@"&" withString:@"%26" options:0 range:NSMakeRange(0, [temp length])];
    //[temp replaceOccurrencesOfString:@"<" withString:@"&lt;" options:0 range:NSMakeRange(0, [temp length])];
    //[temp replaceOccurrencesOfString:@">" withString:@"&gt;" options:0 range:NSMakeRange(0, [temp length])];
    //[temp replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:0 range:NSMakeRange(0, [temp length])];
    //[temp replaceOccurrencesOfString:@"'" withString:@"&apos;" options:0 range:NSMakeRange(0, [temp length])];
	
    return temp;
}



/************************************************
 Method				:	(NSRange)fromString:rangeAfterString:bySkippingNestedOpenTags:toStartOfCloseTag:
 Purpose			:	this method will retrun the range to Escaped String 
 Parameters			:	Finding string, input String, opening tag and closing tag  
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	01-03-2011
 Default			:	NO
 ************************************************/ 

+(NSRange)fromString:(NSString *)frString rangeAfterString:(NSString *)inString  bySkippingNestedOpenTags:(NSString *)openTagStr toStartOfCloseTag:(NSString *)closeTagStr
{
	size_t    strLength = [frString length];
	size_t    foundLocation = 0, tagSearchLocation = 0;
	
	int       nestedOpenTagCnt = 0;
	
	NSRange   startStrRange = NSMakeRange (0, 0);
	NSRange   endStrRange   = NSMakeRange (strLength, 0);  // if no end string, end here
	NSRange   closingSearchRange, nestedSearchRange;
	NSRange   resultRange;
	
	if (inString)  {
		startStrRange = [frString rangeOfString:inString options:0 range:NSMakeRange(0, strLength)];
		if (startStrRange.location == NSNotFound)
			return (startStrRange);	// not found
		foundLocation = NSMaxRange (startStrRange);
		tagSearchLocation = foundLocation;
		nestedOpenTagCnt = 1;
	}
	
	do  {
		closingSearchRange = NSMakeRange (foundLocation, strLength - foundLocation);
		
		if (closeTagStr)  {
			endStrRange = [frString rangeOfString:closeTagStr options:0 range:closingSearchRange];
			if (endStrRange.location == NSNotFound)
				return (endStrRange);	// not found
			nestedOpenTagCnt--;
			foundLocation = endStrRange.location + [closeTagStr length];
		}
		
		if (openTagStr)  {
			nestedSearchRange = NSMakeRange(tagSearchLocation, NSMaxRange(closingSearchRange) - tagSearchLocation);
			nestedSearchRange = [frString rangeOfString:openTagStr options:0 range:nestedSearchRange];
			if (nestedSearchRange.location != NSNotFound)  {
				nestedOpenTagCnt++;	// not found
				tagSearchLocation = nestedSearchRange.location + [openTagStr length];
			}
		}
	} while (nestedOpenTagCnt > 0);
	
	size_t  rangeLoc = startStrRange.location + [inString length];
	size_t  rangeLen = NSMaxRange (endStrRange) - rangeLoc - [closeTagStr length];
	
	resultRange = NSMakeRange (rangeLoc, rangeLen);
	
	return (resultRange);
}



/************************************************
 Method				:	removeHTMLStringFromString:
 Purpose			:	This method will remove the html code from the string and return the non-html string
 Parameters			:	Source html string  
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	01-03-2011
 Default			:	NO
 ************************************************/ 
+(NSString *)removeHTMLStringFromString:(NSString *)html {
	
	NSScanner *theScanner;
	NSString *text = nil;
	theScanner = [NSScanner scannerWithString:html];
	while ([theScanner isAtEnd] == NO) {
		// find start of tag
		[theScanner scanUpToString:@"<" intoString:NULL] ;
		// find end of tag
		[theScanner scanUpToString:@">" intoString:&text] ;
		// replace the found tag with a space
		//(you can filter multi-spaces out later if you wish)
		html = [html stringByReplacingOccurrencesOfString:
				[ NSString stringWithFormat:@"%@>", text]
											   withString:@""];
	} // while //
	html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return html;
}

/************************************************
 Method				:	SetUINavigationBarStyleWithImage:
 Purpose			:	This method will set the Image as Navigation bar 
 Parameters			:	Image name as string 
 Return Value		:	None
 Modified By		:	Alok Patil
 Modified On		:	12-05-2012
 Default			:	NO
 ************************************************/ 
+(void)SetUINavigationBarStyleWithImage:(NSString*)strImageName
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) 
    {
        UIImage *image = [UIImage imageNamed:strImageName];
        [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

@end
