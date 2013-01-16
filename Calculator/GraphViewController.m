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
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar; //to put splitViewBarButtonitem in

@end

@implementation GraphViewController
// implementation of SplitViewBarButtonItemPresenter protocol
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;// to put splitViewBarButtonItem in
- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    if (splitViewBarButtonItem != _splitViewBarButtonItem) {
        NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
        if (_splitViewBarButtonItem) [toolbarItems removeObject:_splitViewBarButtonItem];
        if (splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
        self.toolbar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}

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
    _graphDisplay.delegate = self;
    
//    _graphDisplay.yBlock = ^(double x) //using block replace for using protocol
//    {
//        id result = [CalculatorBrain runProgram:self.program usingVariableValues:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:x], @"x", nil]];
//        double y;
//        if ([result isKindOfClass:[NSString class]])
//        {
//            y = 0;
//        }
//        else
//            y = [result doubleValue];
//        return y;
//    };
}


- (void)setNewProgram:(NSArray *)program
{
    _program = program;
    [self.graphDisplay setNeedsDisplay];
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
