//
//  AddingController.m
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import "AddingController.h"
#import "RoofMeasurement.h"
#import "RoofScopeController.h"


@implementation AddingController

@synthesize AddingButton;
@synthesize NameTxt, AddressTxt, CityTxt,ZipTxt;
@synthesize PhoneTxt,EmailTxt;
@synthesize RoofTypeLbl, RoofType2Lbl, SqftLbl, Sqft2Lbl;
@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		//NSLog(@"init AddingViewController");
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.ScrollView setScrollEnabled:YES];
    [self.ScrollView setContentSize:CGSizeMake(320, 550)];
    //[self.ScrollView setNeedsDisplay];
    self.ScrollView.delegate= self;
    
	
    if ([self.segueAD isEqual:@"detail"])
    {
        self.NameTxt.text = self.RoofE.Name;
        self.AddressTxt.text = self.RoofE.Address;
        self.CityTxt.text = self.RoofE.City;
        self.StateTxt.text = self.RoofE.State;
        self.ZipTxt.text = self.RoofE.Zip;
        self.PhoneTxt.text = self.RoofE.Phone;
        self.EmailTxt.text = self.RoofE.Email;
        
        self.RoofTypeLbl.text = self.RoofE.RoofType.RoofCovering;
        NSString * roof1 = [NSString stringWithFormat:@"%.1f", self.RoofE.RoofType.RoofSqft];
        self.SqftLbl.text = roof1;
        
        self.RoofType2Lbl.text = self.RoofE.RoofType2.RoofCovering;
        NSString * roof2 = [NSString stringWithFormat:@"%.1f", self.RoofE.RoofType2.RoofSqft];
        self.Sqft2Lbl.text = roof2;
        
        self.roofType = self.RoofE.RoofType;
        self.roofType2 = self.RoofE.RoofType2;
        
        NSLog(@"addingcon = %lu", (unsigned long)self.roofType.RoofSize.count);
    }
    
    //Hide keyboard when done
    self.NameTxt.delegate = self;
    self.AddressTxt.delegate = self;
    self.CityTxt.delegate = self;
    self.StateTxt.delegate = self;
    self.ZipTxt.delegate = self;
    self.PhoneTxt.delegate = self;
    self.EmailTxt.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OkPressed:(id)sender
{
    RoofEstimate *roofEstimate = [[RoofEstimate alloc] init];
    
    [roofEstimate setName:self.NameTxt.text];
    [roofEstimate setAddress:self.AddressTxt.text];
    [roofEstimate setCity:self.CityTxt.text];
    [roofEstimate setState:self.StateTxt.text];
    [roofEstimate setZip:self.ZipTxt.text];
    [roofEstimate setPhone:self.PhoneTxt.text];
    [roofEstimate setEmail:self.EmailTxt.text];
    
    [roofEstimate setRoofType:self.roofType];
    [roofEstimate setRoofType2:self.roofType2];
    
    if([roofEstimate.Name isEqualToString:@""])
    {
        UIAlertView *message = [[UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Need a customer name to save."
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
        [message show];
    }
    else
    {
        if ([self.segueAD isEqual:@"adding"])
        {
            [self.delegate addingController:self
                             didAddRoofInfo:[roofEstimate PrintRoofEstimate:roofEstimate]];
        }
        else if ([self.segueAD isEqual:@"detail"])
        {
            [self.delegate addingController:self didAddRoofInfo:[roofEstimate PrintRoofEstimate:roofEstimate] Row:self.Row];
        }
    }
    
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
        [self.delegate addingControllerDidCancel:self];
    }
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"RoofDetails"])
    {
        RoofScopeController *destination = segue.destinationViewController;
        destination.title = @"Roof Scope";
        self.segueRS = [NSString stringWithFormat:@"RoofDetails"];
        destination.delegate = self;
        destination.roofType = self.roofType;
        
    }
    else if ([segue.identifier isEqualToString:@"RoofDetails2"])
    {
        RoofScopeController *destination = segue.destinationViewController;
        destination.title = @"Roof Scope";
        self.segueRS = [NSString stringWithFormat:@"RoofDetails2"];
        destination.delegate = self;
        destination.roofType = self.roofType2;
    }
    else
    {
        NSLog(@"ERROR: Unknown segue identifier!");
        exit(1);
    }
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    svos = self.ScrollView.contentOffset;
    NSLog(@"ScrollView Offset x = %f, y = %f", svos.x, svos.y);
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.ScrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 10;
    [self.ScrollView setContentOffset:pt animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.ScrollView setContentOffset:svos animated:YES];
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - AddingScrollView Delegate

-(void)TouchScreen:(AddingScrollView *)addingScrollView
{
    [self.NameTxt resignFirstResponder];
    [self.AddressTxt resignFirstResponder];
    [self.CityTxt resignFirstResponder];
    [self.StateTxt resignFirstResponder];
    [self.ZipTxt resignFirstResponder];
    [self.PhoneTxt resignFirstResponder];
    [self.EmailTxt resignFirstResponder];
}



#pragma mark - RoofScopeController Delegate

-(void)RoofScopeController:(RoofScopeController *)controller didAddRoofInfo:(RoofType*)roofType;
{
    if([self.segueRS  isEqual: @"RoofDetails"])
    {
        [self setRoofType:roofType];
        self.RoofTypeLbl.text = self.roofType.RoofCovering;
        
        NSString *intToString = [NSString stringWithFormat:@"%.1f", self.roofType.RoofSqft];
        self.SqftLbl.text = intToString;
    }
    else if ([self.segueRS isEqual:@"RoofDetails2"])
    {
        [self setRoofType2:roofType];
        self.RoofType2Lbl.text = self.roofType2.RoofCovering;
        
        NSString *intToString = [NSString stringWithFormat:@"%.1f", self.roofType2.RoofSqft];
        self.Sqft2Lbl.text = intToString;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RoofScopeControllerDidCancel:(RoofScopeController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

