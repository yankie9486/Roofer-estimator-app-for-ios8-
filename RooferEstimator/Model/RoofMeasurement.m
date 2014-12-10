//
//  RoofMeasurement.m
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import "RoofMeasurement.h"

@implementation RoofMeasurement

-(void) SetWidth:(float)width SetLength:(float)lenght
{
    _Width = width;
    _Lenght = lenght;
    _Area = _Width * _Lenght;
}

-(void)CalculateArea
{
    _Area = _Width * _Lenght;
}

-(float) CalculateAllAreaInTable:(NSMutableArray*)array
{
    RoofMeasurement *rm = [[RoofMeasurement alloc] init];
    float totalSqft = 0;
    
    for (int i = 0; i < array.count; i++)
    {
        rm = [array objectAtIndex:i];
        totalSqft += rm.Area;
    }
    return totalSqft;
}

- (void) write:(id<XMLStreamWriter>)writer {
	// do superclass behaviour here
    
    //Width
	[writer writeStartElement:@"Width"];
	[writer writeCharacters:[NSString stringWithFormat:@"%f", self.Width]];
	[writer writeEndElement];
    
    //Lenght
	[writer writeStartElement:@"Lenght"];
	[writer writeCharacters:[NSString stringWithFormat:@"%f", self.Lenght]];
	[writer writeEndElement];
    
    //Area
	[writer writeStartElement:@"Area"];
	[writer writeCharacters:[NSString stringWithFormat:@"%f", self.Area]];
	[writer writeEndElement];
	
}

@end

