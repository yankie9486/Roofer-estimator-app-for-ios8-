//
//  XMLStreamWriter.h
//  xswi
//
//  Created by Thomas Skjølberg on 9/24/10.
//  Copyright 2010 Adactus. All rights reserved.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "RoofEstimate.h"
#import "XMLFileOps.h"

@class RoofEstimate;

@interface XMLReader : NSObject<NSXMLParserDelegate>
{
    NSXMLParser *parser;
    NSMutableString *element;
    
    NSMutableArray *roofTypes;
    NSMutableArray *Measurements;
    
}

@property (nonatomic,strong) NSMutableArray *Customers;

@property (nonatomic,strong) RoofEstimate *roofEstimate;
@property (nonatomic,strong) RoofType *roofType;
@property (nonatomic,strong) RoofMeasurement *roofMeasure;


-(NSString*)RemoveBlankSpaceFromString:(NSString*)text;



@end
