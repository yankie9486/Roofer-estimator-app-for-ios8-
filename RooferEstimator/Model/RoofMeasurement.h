//
//  RoofMeasurement.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLSerializable.h"

@interface RoofMeasurement : NSObject<XMLSerializable>

@property (nonatomic) float Width;
@property (nonatomic) float Lenght;
@property (nonatomic) float Area;
@property (nonatomic, strong) NSMutableArray *RoofSizes;


//Area Formula
-(void) SetWidth:(float)width SetLength:(float)lenght;
-(void) CalculateArea;
-(float) CalculateAllAreaInTable:(NSMutableArray*)array;

@end
