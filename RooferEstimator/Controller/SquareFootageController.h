//
//  SquareFootageController.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoofEstimate.h"
#import "RoofMeasurement.h"

@class SquareFootageController;

@protocol SquareFootageControllerDelegate <NSObject>

- (void)squareFootageControllerDidCancel:
(SquareFootageController *)controller;

- (void)squareFootageController:
(SquareFootageController *)controller
                       didTotalSqft:(float)totalSqft didRoofSizes:(NSMutableArray*)roofSizes;

@required


@end

@interface SquareFootageController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) NSMutableArray *mainArray;

@property (weak, nonatomic) IBOutlet UITextField *widthTxt;

@property (weak, nonatomic) IBOutlet UITextField *lenghtTxt;

@property (weak, nonatomic) IBOutlet UITableView *TableView;

@property (nonatomic, strong) RoofMeasurement *roofMeasurement;

@property (nonatomic, strong) RoofType *roofType;


@property (weak) id <SquareFootageControllerDelegate> delegate;

@end