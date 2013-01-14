//
//  UIGraphView.m
//  Calculator
//
//  Created by viet on 1/14/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "UIGraphView.h"

#import "AxesDrawer.h"  

@interface UIGraphView()
@property (nonatomic) double scale;
@property (nonatomic) CGPoint origin;
@end

@implementation UIGraphView

- (void)setScale:(double)scale {
    _scale = scale;
    [self setNeedsDisplay];
}

- (void)setOrigin:(CGPoint)origin {
    _origin = origin;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib {
    self.scale = 10;
    self.origin = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    UIPinchGestureRecognizer *pinchGestureRegnizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPinch:)];
    [self addGestureRecognizer:pinchGestureRegnizer];
    
    UIPanGestureRecognizer *panGestureRegnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPan:)];
    [self addGestureRecognizer:panGestureRegnizer];
    
    UITapGestureRecognizer *tapGestureRegnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTap:)];
    tapGestureRegnizer.numberOfTapsRequired = 3;
    [self addGestureRecognizer:tapGestureRegnizer];

}

- (void)userDidPinch:(id)sender {
    if ([sender isMemberOfClass:[UIPinchGestureRecognizer class]]) {
        UIPinchGestureRecognizer *recognizer = sender;
        
        self.scale = self.scale * recognizer.scale;
        
        if (self.scale < 1) {
            self.scale = 1;
        } else if (self.scale > 100) {
            self.scale = 100;
        }
        
    }
}

- (void)userDidPan:(id)sender {
    if ([sender isMemberOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *recognizer = sender;
        CGPoint translation = [recognizer translationInView:self];
        [recognizer setTranslation:CGPointZero inView:self];
        self.origin = CGPointMake(self.origin.x + translation.x, self.origin.y + translation.y);
    }
}

- (void)userDidTap:(id)sender {
    if ([sender isMemberOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *recognizer = sender;
        self.origin = [recognizer locationInView:self];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //[AxesDrawer drawAxesInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)originAtPoint:CGPointMake(self.center.y , self.center.y) scale:10];
    [AxesDrawer drawAxesInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)originAtPoint:self.origin scale:self.scale];

    CGContextRef context = UIGraphicsGetCurrentContext();
    for (double x = self.origin.x * -1; x < self.frame.size.width - self.origin.x; x++)
    {
        double y = [self.delegate yCoordinateOfXCoordinate:x / self.scale];
        CGContextFillRect(context, CGRectMake(self.origin.x + x, self.origin.y - self.scale * y, 1, 1));
//        NSLog(@"x = %g, y = %g -> point.x = %g, point.y = %g", x, y, coordinateTranslation.x + scale * x, coordinateTranslation.y - scale * y);
    }


}

@end
