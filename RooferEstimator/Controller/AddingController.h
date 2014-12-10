//
//  AddingController.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoofEstimate.h"
#import "RoofScopeController.h"
#import "AddingScrollView.h"

@class AddingController;

@protocol AddingControllerDelegate<NSObject>

@required

- (void)addingControllerDidCancel:
(AddingController *)controller;
- (void)addingController:
(AddingController *)controller
          didAddRoofInfo:(RoofEstimate*)roofEstimate;
- (void)addingController:(AddingController *)controller
          didAddRoofInfo:(RoofEstimate*)roofEstimate Row:(NSInteger)row;

@end

@interface AddingController : UIViewController
<UITextFieldDelegate, RoofScopeControllerDelegate, UIAlertViewDelegate,AddingScrollViewDelegate,UIScrollViewDelegate>
{
    CGPoint svos;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *AddingButton;
@property (weak, nonatomic) IBOutlet UITextField *NameTxt;
@property (weak, nonatomic) IBOutlet UITextField *AddressTxt;
@property (weak, nonatomic) IBOutlet UITextField *CityTxt;
@property (weak, nonatomic) IBOutlet UITextField *StateTxt;
@property (weak, nonatomic) IBOutlet UITextField *ZipTxt;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTxt;
@property (weak, nonatomic) IBOutlet UITextField *EmailTxt;
@property (weak, nonatomic) IBOutlet UILabel *RoofTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *SqftLbl;
@property (weak, nonatomic) IBOutlet UILabel *RoofType2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *Sqft2Lbl;

@property (weak, nonatomic) IBOutlet AddingScrollView *ScrollView;



@property (strong, nonatomic) RoofEstimate *RoofE;

@property (strong, nonatomic) RoofType *roofType;
@property (strong, nonatomic) RoofType *roofType2;

@property (nonatomic) NSInteger Row;

@property (nonatomic, strong) NSString *segueRS;
@property (nonatomic, strong) NSString *segueAD;


//delegate
@property (weak) id <AddingControllerDelegate> delegate;

@end
