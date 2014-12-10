//
//  RoofEstimate.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoofMeasurement.h"
#import "XMLSerializable.h"

@class RoofType;

@interface RoofEstimate : NSObject<XMLSerializable>

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Address;
@property (nonatomic, strong) NSString *City;
@property (nonatomic, strong) NSString *State;
@property (nonatomic, strong) NSString *Zip;
@property (nonatomic, strong) NSString *Phone;
@property (nonatomic, strong) NSString *Email;

@property (nonatomic, strong) RoofType *RoofType;
@property (nonatomic, strong) RoofType *RoofType2;

-(RoofEstimate *)PrintRoofEstimate:(RoofEstimate*)roofEstimate;

@end

@interface RoofType : NSObject<XMLSerializable>

@property (nonatomic, strong) NSString * RoofCovering;
@property (nonatomic,strong) NSMutableArray *RoofSize;
@property (nonatomic) float RoofSqft;
@property (nonatomic) float RoofSlope;
@property (nonatomic) float RidgeLf;
@property (nonatomic) float DripEdgeLf;
@property (nonatomic) float ValleyLf;
@property (nonatomic) int Stack1;
@property (nonatomic) int Stack2;
@property (nonatomic) int Stack3;
@property (nonatomic, strong) NSString *Notes;

@end
