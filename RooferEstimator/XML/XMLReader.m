//
//  XMLStreamWriter.h
//  xswi
//
//  Created by Thomas Skjølberg on 9/24/10.
//  Copyright 2010 Adactus. All rights reserved.

#import "XMLReader.h"

@implementation XMLReader

-init
{
    if(self == [super init])
    {
        self.roofEstimate = [[RoofEstimate alloc] init];
        self.Customers = [[NSMutableArray alloc] init];
        Measurements = [[NSMutableArray alloc] init];
        roofTypes = [[NSMutableArray alloc] init];
        
        XMLFileOps *xmlFO = [[XMLFileOps alloc] init];
        NSURL *url = [NSURL fileURLWithPath:xmlFO.filePath];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        [parser setDelegate:self];
        
        BOOL success = [parser parse];
        
        if(success)
        {
            NSLog(@"No Errors");
            RoofEstimate *re = [[RoofEstimate alloc] init];
            re = [self.Customers objectAtIndex:0];
            NSLog(@" %lu",(unsigned long)re.RoofType.RoofSize.count);
            
        }
        else
        {
            NSError *error = [parser parserError];
            NSString *s = [error debugDescription];
            NSLog(@"error = %@", s);
        }
        
        NSLog(@"");
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary*)attributeDict
{
    element = [NSMutableString string];
    
    if ([elementName isEqualToString:@"RoofEstimate"])
    {
        self.roofEstimate = [[RoofEstimate alloc] init];
    }
    else if ([elementName isEqualToString:@"RoofType"])
    {
        self.roofType = [[RoofType alloc] init];
    }
    else if ([elementName isEqualToString:@"RoofMeasurement"])
    {
        self.roofMeasure = [[RoofMeasurement alloc] init];
    }
    else if ([elementName isEqualToString:@"LeadStack"])
    {
        NSString *Stack1 =[attributeDict valueForKey:@"Stack1"];
        self.roofType.Stack1 = Stack1.intValue;
        NSString *Stack2 =[attributeDict valueForKey:@"Stack2"];
        self.roofType.Stack2 = Stack2.intValue;
        NSString *Stack3 =[attributeDict valueForKey:@"Stack3"];
        self.roofType.Stack3 = Stack3.intValue;
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"RoofEstimates"])
    {
        NSLog(@"end");
        return;
    }
    else if ([elementName isEqualToString:@"RoofEstimate"])
    {
        if (roofTypes.count == 1)
        {
            self.roofEstimate.RoofType = roofTypes[0];
        }
        else
        {
            self.roofEstimate.RoofType = roofTypes[0];
            self.roofEstimate.RoofType2 = roofTypes[1];
        }
        
        [self.Customers addObject:self.roofEstimate];
        
        self.roofEstimate= nil;
        [roofTypes removeAllObjects];
    }
    else if ([elementName isEqualToString:@"Name"])
    {
        self.roofEstimate.Name = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"Address"])
    {
        self.roofEstimate.Address = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"City"])
    {
        self.roofEstimate.City = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"State"])
    {
        self.roofEstimate.State = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"Zip"])
    {
        self.roofEstimate.Zip = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"Phone"])
    {
        self.roofEstimate.Phone = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"Email"])
    {
        self.roofEstimate.Email = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"RoofType"]) //Roof Type
    {
        self.roofType.RoofSize = [[NSMutableArray alloc] init];
        for (int i =0; i < Measurements.count; i++)
        {
            [self.roofType.RoofSize addObject:[Measurements objectAtIndex:i]];
        }
        
        [roofTypes addObject:self.roofType];
        
        self.roofType = [[RoofType alloc] init];
        [Measurements removeAllObjects];
    }
    else if ([elementName isEqualToString:@"RoofCover"])
    {
        self.roofType.RoofCovering = [self RemoveBlankSpaceFromString:element];
    }
    else if ([elementName isEqualToString:@"RoofSqft"])
    {
        self.roofType.RoofSqft = element.floatValue;
    }
    else if ([elementName isEqualToString:@"RoofMeasurement"])
    {
        [Measurements addObject:self.roofMeasure];
        self.roofMeasure = nil;
    }
    else if ([elementName isEqualToString:@"Width"])
    {
        self.roofMeasure.Width = element.floatValue;
    }
    else if ([elementName isEqualToString:@"Lenght"])
    {
        self.roofMeasure.Lenght = element.floatValue;
    }
    else if ([elementName isEqualToString:@"Area"])
    {
        self.roofMeasure.Area = element.floatValue;
    }
    else if ([elementName isEqualToString:@"RoofSlope"])
    {
        self.roofType.RoofSlope = element.floatValue;
    }
    else if ([elementName isEqualToString:@"RidgeLf"])
    {
        self.roofType.RidgeLf = element.floatValue;
    }
    else if ([elementName isEqualToString:@"DripEdgeLf"])
    {
        self.roofType.DripEdgeLf = element.floatValue;
    }
    else if ([elementName isEqualToString:@"Notes"])
    {
        if (element == NULL)
            self.roofType.Notes = @" ";
        else
            self.roofType.Notes = [self RemoveBlankSpaceFromString:element];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(element == nil)
        element = [[NSMutableString alloc] init];
    
    [element appendString:string];
    
}

-(NSString*)RemoveBlankSpaceFromString:(NSString*)text
{
    NSString *rawString = text;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    
    return trimmed;
}



@end

