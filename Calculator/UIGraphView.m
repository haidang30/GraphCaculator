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
    [AxesDrawer drawAxesInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)originAtPoint:CGPointMake(self.frame.size.width/2 , self.frame.size.height/2) scale:10];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (double x = (self.frame.size.width / 2) * -1; x < self.frame.size.width/2; x++)
    {
        double y = [self.delegate yCoordinateOfXCoordinate:x];
        CGContextFillRect(context, CGRectMake(x, y, 1, 1));
    }
    

}

@end
