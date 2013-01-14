//
//  UIGraphView.h
//  Calculator
//
//  Created by viet on 1/14/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphViewDelegate <NSObject>

- (double) yCoordinateOfXCoordinate:(double)xValue;

@end

@interface UIGraphView : UIView
@property (nonatomic,weak) id <GraphViewDelegate> delegate;
@end

