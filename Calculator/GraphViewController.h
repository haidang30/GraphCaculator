//
//  UIGraphView.h
//  Calculator
//
//  Created by viet on 1/14/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGraphView.h"

@interface GraphViewController : UIViewController <GraphViewDelegate> 

- (void)setNewProgram:(NSArray *)program;

@end
