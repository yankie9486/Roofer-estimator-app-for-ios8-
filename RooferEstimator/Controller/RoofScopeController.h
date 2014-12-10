//
//  RoofScopeController.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoofEstimate.h"
#import "SquareFootageController.h"
#import "RoofDetailScrollView.h"

@class RoofScopeController;

@protocol RoofScopeControllerDelegate <NSObject>

@required
- (void)RoofScopeControllerDidCancel:
(RoofScopeController *)controller;
- (void)RoofScopeController:
(RoofScopeController *)controller
             didAddRoofInfo:(RoofType*)roofType;
@end

@interface RoofScopeController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource, SquareFootageControllerDelegate, UITextFieldDelegate,
RoofDetailScrollViewDelegate, UITextViewDelegate, UIAlertViewDelegate,UIScrollViewDelegate>
{
    NSString *RoofCoverName;
    CGPoint svos;
}

@property (weak, nonatomic) IBOutlet UIPickerView *RoofCoverPicker;
//UIPicker
@property (strong, nonatomic) NSArray *RoofCover;

@property (weak, nonatomic) IBOutlet UILabel *RoofArea;

@property (strong, nonatomic) RoofType *roofType;

@property (weak) id <RoofScopeControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *RoofSlopeTxt;
@property (weak, nonatomic) IBOutlet UITextField *RidgeTxt;
@property (weak, nonatomic) IBOutlet UITextField *DripEdgeTxt;
@property (weak, nonatomic) IBOutlet UITextField *ValleyTxt;
@property (weak, nonatomic) IBOutlet UITextField *Stack1Txt;
@property (weak, nonatomic) IBOutlet UITextField *Stack2Txt;
@property (weak, nonatomic) IBOutlet UITextField *Stack3Txt;
@property (weak, nonatomic) IBOutlet UITextView *NotesTxt;

@property (weak, nonatomic) IBOutlet RoofDetailScrollView *RoofDetailSView;


@end
