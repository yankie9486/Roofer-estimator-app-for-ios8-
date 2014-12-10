//
//  RoofEstimate.m
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import "RoofEstimate.h"



@implementation RoofType

-init
{
    if(self == [super init])
    {
        
    }
    return self;
}

- (void) write:(id<XMLStreamWriter>)writer {
    
    [writer writeStartElement:@"RoofType"];
    
	[writer writeStartElement:@"RoofCover"];
	[writer writeCharacters:self.RoofCovering];
	[writer writeEndElement];
	
	[writer writeStartElement:@"RoofSqft"];
	[writer writeCharacters:[NSString stringWithFormat:@"%f", self.RoofSqft]];
	[writer writeEndElement];
    
    RoofMeasurement *RM = [[RoofMeasurement alloc] init];
    
    for (int x =0; x < self.RoofSize.count ; x++)
    {
        RM = [self.RoofSize objectAtIndex:x];
        [writer writeStartElement:[NSString stringWithFormat:@"RoofMeasurement"]];
        [writer writeAttribute:@"Measurement" value:[NSString stringWithFormat:@"%d",x]];
        [RM write:writer];
        [writer writeEndElement];
    }
    
    [writer writeStartElement:@"RoofSlope"];
	[writer writeCharacters:[NSString stringWithFormat:@"%f", self.RoofSlope]];
	[writer writeEndElement];
    
    
    [writer writeStartElement:@"RidgeLf"];
    [writer writeCharacters:[NSString stringWithFormat:@"%f", self.RidgeLf]];
    [writer writeEndElement];
    
    [writer writeStartElement:@"DripEdgeLf"];
	[writer writeCharacters:[NSString stringWithFormat:@"%f", self.DripEdgeLf]];
	[writer writeEndElement];
    
    
    [writer writeStartElement:@"LeadStacks"];
    
    [writer writeAttribute:@"Stack1" value:[NSString stringWithFormat:@"%d",self.Stack1]];
    [writer writeAttribute:@"Stack2" value:[NSString stringWithFormat:@"%d",self.Stack2]];
    [writer writeAttribute:@"Stack3" value:[NSString stringWithFormat:@"%d",self.Stack3]];
	
	[writer writeEndElement];
    
    [writer writeStartElement:@"Notes"];
    
    [writer writeCharacters:[NSString stringWithFormat:@"%@", self.Notes]];
	
	[writer writeEndElement];
    
    
    
    [writer writeEndElement];
}

@end

@implementation RoofEstimate

-init
{
    if(self == [super init])
    {
        
    }
    return self;
}



- (void) write:(id<XMLStreamWriter>)writer {
    
    [writer writeStartElement:@"RoofEstimate"];
	// write <Name> </Name>
	[writer writeStartElement:@"Name"];
	[writer writeCharacters:self.Name];
	[writer writeEndElement];
	
	// write <Address> </Address>
	[writer writeStartElement:@"Address"];
    [writer writeCharacters:self.Address];
	[writer writeEndElement];
    
    [writer writeStartElement:@"City"];
    [writer writeCharacters:self.City];
	[writer writeEndElement];
    
    [writer writeStartElement:@"State"];
    [writer writeCharacters:self.State];
	[writer writeEndElement];
    
    [writer writeStartElement:@"Zip"];
    [writer writeCharacters:self.Zip];
	[writer writeEndElement];
    
    [writer writeStartElement:@"Phone"];
    [writer writeCharacters:self.Phone];
	[writer writeEndElement];
    
    [writer writeStartElement:@"Email"];
    [writer writeCharacters:self.Email];
	[writer writeEndElement];
    
    if(self.RoofType == nil)
    {
        self.RoofType = [[RoofType alloc] init];
        self.RoofType.RoofSqft = 0;
        self.RoofType.RoofSize = [[NSMutableArray alloc] init];
        self.RoofType.RoofCovering = @"none";
        [self.RoofType write:writer];
    }
    else
    {
        [self.RoofType write:writer];
    }
    
    if(self.RoofType2 == nil)
    {
        self.RoofType2 = [[RoofType alloc] init];
        self.RoofType2.RoofSqft = 0;
        self.RoofType2.RoofSize = [[NSMutableArray alloc] init];
        self.RoofType2.RoofCovering = @"none";
        [self.RoofType2 write:writer];
    }
    else
    {
        [self.RoofType2 write:writer];
    }
    
    [writer writeEndElement];
	
}

-(RoofEstimate *)PrintRoofEstimate:(RoofEstimate*)roofEstimate
{
    if(roofEstimate.RoofType == nil)
    {
        roofEstimate.RoofType.RoofCovering = @"None";
        roofEstimate.RoofType.RoofSqft = 0.0;
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        RoofMeasurement *rm = [[RoofMeasurement alloc] init];
        [rm setWidth:0.0];
        [rm setLenght:0.0];
        [rm CalculateArea];
        [temp addObject:rm];
        
        roofEstimate.RoofType.RoofSize = temp;
    }
    
    if(roofEstimate.RoofType2 == nil)
    {
        roofEstimate.RoofType2.RoofCovering = @"None";
        roofEstimate.RoofType2.RoofSqft = 0.0;
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        RoofMeasurement *rm = [[RoofMeasurement alloc] init];
        [rm setWidth:0.0];
        [rm setLenght:0.0];
        [rm CalculateArea];
        [temp addObject:rm];
        
        roofEstimate.RoofType2.RoofSize = temp;
    }
    
    return roofEstimate;
}

@end
