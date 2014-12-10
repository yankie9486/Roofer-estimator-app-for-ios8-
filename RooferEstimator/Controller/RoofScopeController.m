//
//  RoofScopeController.m
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import "RoofScopeController.h"

@interface RoofScopeController ()

@end

@implementation RoofScopeController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.RoofDetailSView setScrollEnabled:YES];
    [self.RoofDetailSView setContentSize:CGSizeMake(320, 800)];
    //[self.RoofDetailSView setContentOffset:CGPointMake(0, -120)];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.RoofDetailSView.delegate = self;
    
    self.RoofCover = [[NSArray alloc] initWithObjects:@"None",@"3-tab Shingle",@"Dimenisonal Shingle", @"Tile",@"Built-up-Roof",@"Self-adhered",@"Metal", @"Seal-O-Flex", nil];
    
    
    if (self.roofType == nil)
    {
        self.roofType = [[RoofType alloc] init];
        self.roofType.RoofCovering = self.RoofCover[0];
        self.roofType.RoofSize = [[NSMutableArray alloc] init];
        
    }
    else
    {
        NSString *rtS = [NSString stringWithFormat:@"%.1f",self.roofType.RoofSqft];
        self.RoofArea.text = rtS;
        RoofCoverName = self.roofType.RoofCovering;
        NSInteger temp = [self GetSelectedRow:RoofCoverName];
        [self.RoofCoverPicker selectRow:temp inComponent:0 animated:YES];
        
        NSString *slopeString = [NSString stringWithFormat:@"%.1f", self.roofType.RoofSlope];
        self.RoofSlopeTxt.text = slopeString;
        
        NSString *ridgeString = [NSString stringWithFormat:@"%.1f", self.roofType.RidgeLf];
        self.RidgeTxt.text = ridgeString;
        
        NSString *dripEdgeString = [NSString stringWithFormat:@"%.1f", self.roofType.DripEdgeLf];
        self.DripEdgeTxt.text = dripEdgeString;
        
        NSString *valleyString = [NSString stringWithFormat:@"%.1f", self.roofType.ValleyLf];
        self.ValleyTxt.text = valleyString;
        
        NSString *stack1String = [NSString stringWithFormat:@"%d", self.roofType.Stack1];
        self.Stack1Txt.text = stack1String;
        
        NSString *stack2String = [NSString stringWithFormat:@"%d", self.roofType.Stack2];
        self.Stack2Txt.text = stack2String;
        
        NSString *stack3String = [NSString stringWithFormat:@"%d", self.roofType.Stack3];
        self.Stack3Txt.text = stack3String;
        
        self.NotesTxt.text = self.roofType.Notes;
        
        NSLog(@" mes %lu:", (unsigned long)self.roofType.RoofSize.count);
        
        
    }
    
    
    
    self.RoofSlopeTxt.delegate = self;
    self.RidgeTxt.delegate = self;
    self.DripEdgeTxt.delegate = self;
    self.ValleyTxt.delegate = self;
    self.Stack1Txt.delegate = self;
    self.Stack2Txt.delegate = self;
    self.Stack3Txt.delegate = self;
    self.NotesTxt.delegate = self;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)GetSelectedRow:(NSString*)name
{
    NSNumber *row = [NSNumber numberWithInt:0];
    NSInteger Row = [row integerValue];
    NSString *tempRC;
    
    for (int i = 0; i < self.RoofCover.count; i++)
    {
        tempRC = [self.RoofCover objectAtIndex:i];
        
        if (tempRC == name)
        {
            row = [NSNumber numberWithInt:i];
            Row = [row integerValue];
            return Row;
        }
        else
        {
            row = [NSNumber numberWithInt:0];
        }
    }
    return Row;
}


- (IBAction)OkPressed:(id)sender
{
    self.roofType.RoofCovering = RoofCoverName;
    self.roofType.RoofSqft = self.RoofArea.text.floatValue;
    self.roofType.RoofSlope = self.RoofSlopeTxt.text.floatValue;
    self.roofType.RidgeLf = self.RidgeTxt.text.floatValue;
    self.roofType.DripEdgeLf = self.DripEdgeTxt.text.floatValue;
    self.roofType.Stack1 = self.Stack1Txt.text.intValue;
    self.roofType.Stack2 = self.Stack2Txt.text.intValue;
    self.roofType.Stack3 = self.Stack3Txt.text.intValue;
    
    if (self.NotesTxt.text == nil)
        self.roofType.Notes = @"";
    else
        self.roofType.Notes = self.NotesTxt.text;
    
    [self.delegate RoofScopeController:self didAddRoofInfo:self.roofType];
}


- (IBAction)CancelPressed:(id)sender
{
    
    UIAlertView *message = [[UIAlertView alloc]
                            initWithTitle:@"Warning"
                            message:@"Any unsave data will be Lost. Press Yes to proceed."
                            delegate:self
                            cancelButtonTitle:@"No"
                            otherButtonTitles:nil];
    [message addButtonWithTitle:@"Yes"];
    [message show];
    
    
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Yes"])
    {
        [self.delegate RoofScopeControllerDidCancel:self];
    }
}


#pragma mark - UITextField Delegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.RoofSlopeTxt resignFirstResponder];
    [self.RidgeTxt resignFirstResponder];
    [self.DripEdgeTxt resignFirstResponder];
    [self.ValleyTxt resignFirstResponder];
    [self.Stack1Txt resignFirstResponder];
    [self.Stack2Txt resignFirstResponder];
    [self.Stack3Txt resignFirstResponder];
    [self.NotesTxt resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    svos = self.RoofDetailSView.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.RoofDetailSView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [self.RoofDetailSView setContentOffset:pt animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.RoofDetailSView setContentOffset:svos animated:YES];
    [textField resignFirstResponder];
    NSLog(@"txtfield shouldreturn");
    return YES;
}


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.RoofCover count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.RoofCover objectAtIndex:row];
}

#pragma mark -
#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    switch (row)
    {
        case 0:
            RoofCoverName = @"None";
            break;
        case 1:
            RoofCoverName = @"3-tab Shingle";
            break;
        case 2:
            RoofCoverName = @"Dimenisonal Shingle";
            break;
        case 3:
            RoofCoverName = @"Tile";
            break;
        case 4:
            RoofCoverName = @"Built-up-Roof";
            break;
        case 5:
            RoofCoverName = @"Self-adhered";
            break;
        case 6:
            RoofCoverName = @"Metal";
            break;
        case 7:
            RoofCoverName = @"Seal-O-Flex";
            break;
            
        default:
            break;
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SquareFootage"])
    {
        SquareFootageController *destination = segue.destinationViewController;
        destination.title = @"Square Footage";
        destination.delegate = self;
        destination.roofType = self.roofType;
    }
    else
    {
        NSLog(@"ERROR: Unknown segue identifier!");
        exit(1);
    }
}


#pragma mark SquareFootageViewController Delegate

-(void)squareFootageController:(SquareFootageController *)controller didTotalSqft:(float)totalSqft didRoofSizes:(NSMutableArray *)roofSizes
{
    NSString *toString = [NSString stringWithFormat:@"%.1f",totalSqft];
    self.RoofArea.text = toString;
    self.roofType.RoofSize = roofSizes;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)squareFootageControllerDidCancel:(SquareFootageController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark SquareFootageViewController Delegate

-(void)TouchScreen:(RoofDetailScrollView *)roofDetailSV
{
    [self.RidgeTxt resignFirstResponder];
    [self.DripEdgeTxt resignFirstResponder];
    [self.ValleyTxt resignFirstResponder];
    [self.Stack1Txt resignFirstResponder];
    [self.Stack2Txt resignFirstResponder];
    [self.Stack3Txt resignFirstResponder];
    [self.NotesTxt resignFirstResponder];
    NSLog(@"touch screen");
}

@end

