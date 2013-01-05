//
//  ZoomableRotationableImageView.h
// 
//
//  Created by Benny Sheerin on 21/07/12.
//  Copyright (c) 2012 bennythemink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomableRotationableImageView : UIImageView <UIGestureRecognizerDelegate> {
    
@protected
    UIPinchGestureRecognizer *_pinchRecogniser;
    UIRotationGestureRecognizer *_rotateRecogniser;
}

- (IBAction) handlePinch:(UIPinchGestureRecognizer*)recogniser;
- (IBAction) handleRotate:(UIRotationGestureRecognizer*)recogniser;
- (void) reset;

@end
