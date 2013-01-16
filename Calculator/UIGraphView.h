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
typedef double (^y_calculating_type) (double x);

@property (nonatomic,weak) id <GraphViewDelegate> delegate;
@property (nonatomic,strong) y_calculating_type yBlock;
@end
