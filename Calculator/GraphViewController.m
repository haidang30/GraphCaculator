//
//  UIGraphView.m
//  Calculator
//
//  Created by viet on 1/14/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "GraphViewController.h"
#import "CalculatorBrain.h"

@interface GraphViewController ()

@property (weak, nonatomic) IBOutlet UIGraphView *graphDisplay;
@property (nonatomic,strong) NSArray *program;//save the calculator program.

@end

@implementation GraphViewController

- (double)yCoordinateOfXCoordinate:(double)xValue
{
    id result = [CalculatorBrain runProgram:self.program usingVariableValues:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:xValue], @"x", nil]];
    if ([result isKindOfClass:[NSString class]])
    {
        return 0;
    }
    else
        return [result doubleValue];
//    return [CalculatorBrain runProgram:self.program ];
}

- (void)setGraphDisplay:(UIGraphView *)graphDisplay
{
    _graphDisplay = graphDisplay;
    self.graphDisplay.delegate = self;
}


- (void)setNewProgram:(NSArray *)program
{
    _program = program;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
