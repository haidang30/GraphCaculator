//
//  CalculatorViewController.m
//  Calculator
//
//  Created by viet on 1/7/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "GraphViewController.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL alreadyDot;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSString *programStackDescription;
@property (nonatomic, strong) NSDictionary *variableValues;
@end

@implementation CalculatorViewController

- (void)awakeFromNib {
    self.userIsInTheMiddleOfEnteringANumber = YES;
    self.splitViewController.delegate = self;
}


//- (id)initWithNibName:(NSString *)nibNameOrNilString bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNilString bundle:nibBundleOrNil];
//    
//    if (self) {
//
//    }
//    
//    return self;
//}

- (CalculatorBrain *)brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (NSString *)programStackDescription {
    if (!_programStackDescription) {
        _programStackDescription = [[NSString alloc] init];
    }
    return _programStackDescription;
}

- (NSDictionary *)variableValues {
    if (!_variableValues) {
        _variableValues = [[NSDictionary alloc] init];
    }
    return _variableValues;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GraphViewController *destinationViewController = segue.destinationViewController;
    
    [destinationViewController setNewProgram:self.brain.program];
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *pressedDigit = sender.currentTitle;
    
    // Replace default display @"0" with an initial digit (not dot sign)
    if ([self.display.text isEqualToString:@"0"]) {
        if (![pressedDigit isEqualToString:@"."]) {
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    }
    
    // For not appending another dot @"."
    if ([pressedDigit isEqualToString:@"."] && self.alreadyDot){
        return;
    }

    
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        if (!self.alreadyDot || ![pressedDigit isEqualToString:@"."]) {
            self.display.text = [self.display.text stringByAppendingString:pressedDigit];
            if ([pressedDigit isEqualToString:@"."]) {
                self.alreadyDot = YES;
            }
        }
    } else {
        // For not replacing @"0" with @"."
        if (![pressedDigit isEqualToString:@"."]) {
            self.display.text = pressedDigit;
        }
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.stackDisplay.text = @"";
    self.programStackDescription = @"";
    self.variableDisplay.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = YES;
    self.alreadyDot = NO;
    [self.brain clearOperandStack];
}

- (IBAction)backspacePressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {        
        if (self.display.text.length  > 1) {
            if ([self.display.text hasSuffix:@"."]) {
                self.alreadyDot = NO;
            }
            
            NSUInteger index = self.display.text.length;

            self.display.text = [self.display.text substringToIndex:index - 1];

        } else {
            self.display.text = @"0";
        }
    }
    
}

- (IBAction)operationPressed:(UIButton *)sender {    
    NSString *operation = [sender currentTitle];    
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    //Add operation to stackDisplay after the current text
//    self.stackTest = [NSString stringWithFormat:@"%@ %@", self.stackTest, operation];
    
    
    id result = [self.brain performOperation:operation];

    if ([result isKindOfClass:[NSString class]]) {
        self.variableDisplay.text = [NSString stringWithFormat:@"%@", result];
    } else if ([result isKindOfClass:[NSNumber class]]) {
        self.display.text = [NSString stringWithFormat:@"%g", [result doubleValue]];
    }
    
    self.programStackDescription = [CalculatorBrain descriptionOfProgram:self.brain.program];
    self.stackDisplay.text = [NSString stringWithFormat:@"%@ =", self.programStackDescription];
}

- (IBAction)testPressed:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"Test 1"]) {
        self.variableValues = [NSDictionary dictionaryWithObjectsAndKeys:
                               [[NSNumber alloc] initWithDouble:3], @"a",
                               [[NSNumber alloc] initWithDouble:0], @"b",
                               [[NSNumber alloc] initWithDouble:-4], @"x", nil];
    } else if ([sender.currentTitle isEqualToString:@"Test 2"]) {
        self.variableValues = [NSDictionary dictionaryWithObjectsAndKeys:
                               [[NSNumber alloc] initWithDouble:1], @"a",
                               [[NSNumber alloc] initWithDouble:5], @"b",
                               [[NSNumber alloc] initWithDouble:10], @"x", nil];
    }
    
    
    id result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.variableValues];
    if ([result isKindOfClass:[NSString class]]) {
        self.variableDisplay.text = [NSString stringWithFormat:@"%@", result];
    } else if ([result isKindOfClass:[NSNumber class]]) {
        self.display.text = [NSString stringWithFormat:@"%g", [result doubleValue]];
    }
    
    NSMutableString *variableValueDescription = [[NSMutableString alloc] initWithString:@""];
    for (id key in self.variableValues) {
        if ([key isKindOfClass:[NSString class]]) {
            NSString *variableName = key;
            NSNumber *variableValue = [self.variableValues objectForKey:key];
            [variableValueDescription appendFormat:@"%@ = %@  ", variableName, variableValue];
        }
    }
    self.variableDisplay.text = variableValueDescription;
}


- (IBAction)signPressed {
//    self.display.text = [NSString stringWithFormat:@"%g",[self.display.text doubleValue] * -1];
    if ([self.display.text isEqualToString:@"0"])
        return;
    if (![self.display.text hasPrefix:@"-"]) {
        self.display.text = [@"-" stringByAppendingString:self.display.text];
    } else {
        self.display.text = [self.display.text substringFromIndex:1];
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.alreadyDot = NO;
    
    //Add operand to stackDisplay
//    self.stackTest = [NSString stringWithFormat:@"%@ %@", self.stackTest, self.display.text];
    self.programStackDescription = [CalculatorBrain descriptionOfProgram:self.brain.program];
    self.stackDisplay.text = [NSString stringWithFormat:@"%@ =", self.programStackDescription];
}
- (IBAction)undoPressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self backspacePressed];
        if ([self.display.text isEqualToString:@"0"]) {
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    } else {
        [self.brain popAnObjectOutOfProgramStack];
        [self operationPressed:nil];
    }
}


- (GraphViewController *)splitViewGraphController
{
    id cvc = [self.splitViewController.viewControllers lastObject];
    if (![cvc isKindOfClass:[GraphViewController class]]) {
        cvc = nil;
    }
    return cvc;
}
- (IBAction)showGraph:(id)sender {
    if ([self splitViewGraphController]) {
        [[self splitViewGraphController] setNewProgram:self.brain.program];
    } else {
        [self performSegueWithIdentifier:@"segueToGraph" sender:self]; // else segue using ShowDiagnosis
    }
}

#pragma UISplitViewControllerDelegate
- (id <SplitViewBarButtonItemPresenter>)splitViewBarButtonItemPresenter
{
    id detailVC = [self.splitViewController.viewControllers lastObject];
    if (![detailVC conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter)]) {
        detailVC = nil;
    }
    return detailVC;
}

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    return [self splitViewBarButtonItemPresenter] ? UIInterfaceOrientationIsPortrait(orientation) : NO;
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = self.title;
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
