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

@end

@implementation UIGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //[AxesDrawer drawAxesInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)originAtPoint:CGPointMake(self.center.y , self.center.y) scale:10];
    CGPoint coordinatesTranslation = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    double scale = 10;
    
    [AxesDrawer drawAxesInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)originAtPoint:coordinatesTranslation scale:scale];

    CGContextRef context = UIGraphicsGetCurrentContext();
    for (double x = coordinatesTranslation.x * -1; x < coordinatesTranslation.x; x++)
    {
        double y = [self.delegate yCoordinateOfXCoordinate:x / scale];
        CGContextFillRect(context, CGRectMake(coordinatesTranslation.x + x, coordinatesTranslation.y - scale * y, 1, 1));
//        NSLog(@"x = %g, y = %g -> point.x = %g, point.y = %g", x, y, coordinateTranslation.x + scale * x, coordinateTranslation.y - scale * y);
    }


}

@end
