//
//  XMLFileOps.m
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import "XMLFileOps.h"

@implementation XMLFileOps

- (id)init
{
    self = [super init];
    if (self)
    {
        //get File Path
        self.fileManager = [NSFileManager defaultManager];
        self.documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSLog(@"%@", self.documentsPath);
        self.filePath = [self.documentsPath stringByAppendingPathComponent:@"Save.xml"];
        NSLog(@"%@",self.filePath);
    }
    return self;
}



-(void)saveToXML:(NSMutableArray*)content
{
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
    NSString *file;
    NSError *error = nil;
    
    //Start XML Doc
    [xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
    [xmlWriter writeStartElement:@"RoofEstimates"];
    
    for (RoofEstimate *roof in content)
    {
        [roof write:xmlWriter];
    }
    
    [xmlWriter writeEndElement];
    [xmlWriter writeEndDocument];
    
    file = [xmlWriter toString];
    
    if ([self doesFileExist])
    {
        
        [self.fileManager removeItemAtPath:self.filePath error:&error];
        //Write File
        [file writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    else
    {
        [file writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
}

-(BOOL)doesFileExist
{
    fileExists = [self.fileManager fileExistsAtPath:self.filePath];
    return fileExists;
}

-(NSMutableArray*)LoadXml
{
    
    XMLReader *XmlReader = [[XMLReader alloc] init];
    return XmlReader.Customers;
}

@end
