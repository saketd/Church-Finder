//
//  ZoomableRotationableImageView.m
// 
//
//  Created by Benny Sheerin on 21/07/12.
//  Copyright (c) 2012 bennythemink. All rights reserved.
//

#import "ZoomableRotationableImageView.h"

@interface ZoomableRotationableImageView ()
- (void) setUpGestures;
@end

@implementation ZoomableRotationableImageView

#pragma mark - Initialisation Overrides

- (id) initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self setUpGestures];
    }
    return self;
}

- (id) initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self setUpGestures];
    }
    return self;
}

- (id) init {
    self = [super init];
    if (self) {
        [self setUpGestures];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpGestures];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpGestures];
    }
    return self;
}

#pragma mark - Utility Methods

- (void) setUpGestures {
    
    [self setUserInteractionEnabled:TRUE];
    _pinchRecogniser = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    _rotateRecogniser = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    
    [_pinchRecogniser setDelegate:self];
    [_rotateRecogniser setDelegate:self];
    
    [self addGestureRecognizer:_pinchRecogniser];
    [self addGestureRecognizer:_rotateRecogniser];
}

- (IBAction) handlePinch:(UIPinchGestureRecognizer*)recogniser {
    recogniser.view.transform = CGAffineTransformScale(recogniser.view.transform, recogniser.scale, recogniser.scale);
    recogniser.scale = 1;
}

- (IBAction) handleRotate:(UIRotationGestureRecognizer*)recogniser {
    recogniser.view.transform = CGAffineTransformRotate(recogniser.view.transform, recogniser.rotation);
    recogniser.rotation = 0;
}

- (void) reset {
    self.transform = CGAffineTransformIdentity;
}

#pragma mark - UIGestureRecognizer Delegate Methods

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return TRUE;
}

@end
