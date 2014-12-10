//
//  SquareFootageController.m
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import "SquareFootageController.h"
#import "RoofEstimate.h"

@interface SquareFootageController ()

@end

@implementation SquareFootageController

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		NSLog(@"init SqaureFootageViewController");
        
        
        
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (self.roofType.RoofSize == Nil)
    {
        self.mainArray = [[NSMutableArray alloc] init];
    }
    else
    {
        self.mainArray = self.roofType.RoofSize;
        NSLog(@"Square: %lu", (unsigned long)self.mainArray.count);
    }
    
    _widthTxt.delegate = self;
    _lenghtTxt.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddBtnPressed:(id)sender
{
    NSScanner * scannerW = [NSScanner scannerWithString:self.widthTxt.text];
    NSInteger * integerW =0;
    
    NSScanner * scannerL = [NSScanner scannerWithString:self.lenghtTxt.text];
    NSInteger * integerL =0;
    
    if([scannerW scanInteger:integerW] && [scannerL scanInteger:integerL])
    {
        RoofMeasurement *rm = [[RoofMeasurement alloc] init];
        [rm SetWidth:self.widthTxt.text.floatValue SetLength:self.lenghtTxt.text.floatValue];
        self.roofMeasurement = rm;
        [self.mainArray addObject:rm];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.mainArray count]-1 inSection:0];
        [self.TableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        UIAlertView *message = [[UIAlertView alloc]
                                initWithTitle:@"Warning"
                                message:@"You need to enter a number."
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
        [message show];
    }
    
    
    [_widthTxt setText:@""];
    [_lenghtTxt setText:@""];
    
    [_widthTxt resignFirstResponder];
    [_lenghtTxt resignFirstResponder];
    
    
}

- (IBAction)OkPressed:(id)sender
{
    RoofMeasurement *rm = [[RoofMeasurement alloc] init];
    
    [self.delegate squareFootageController:self
                                  didTotalSqft:[rm CalculateAllAreaInTable:self.mainArray]
                                  didRoofSizes:self.mainArray];
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
    
    // UIColor *color = [[UIColor alloc] initWithRed:53 green:127 blue:52 alpha:1.0];
    //message.
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Yes"])
    {
        [self.delegate squareFootageControllerDidCancel:self];
    }
}



#pragma mark - UITextField Delegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.widthTxt resignFirstResponder];
    [self.lenghtTxt resignFirstResponder];
    NSLog(@"touch screen");
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mainArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AreaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    RoofMeasurement *rm = [[RoofMeasurement alloc] init];
    rm = [self.mainArray objectAtIndex:indexPath.row];
    
    NSString * cellTxt = [NSString stringWithFormat:@" %.1f X %.1f = %.1f ",rm.Width,rm.Lenght,rm.Area];
    
    [cell.textLabel setText:cellTxt];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source first…
        @autoreleasepool
        {
            NSMutableArray *tempContent = [self.mainArray mutableCopy];
            [tempContent removeObject:[tempContent                                                                objectAtIndex:indexPath.row]];
            self.mainArray = tempContent;
        }
        //now delete the row from the table view:
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
