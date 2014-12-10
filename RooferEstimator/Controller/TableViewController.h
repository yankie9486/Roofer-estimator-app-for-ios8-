//
//  TableViewController.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoofEstimate.h"
#import "XmlFileOps.h"
#import "XMLReader.h"
#import "AddingController.h"

@interface TableViewController : UITableViewController<AddingControllerDelegate>
{
    AddingController *avc;
    NSData* myData;
    XMLFileOps *xmlFO;
}

@property (strong, nonatomic) NSMutableArray *content;
@property (strong, nonatomic) RoofEstimate *RoofE;

@end
