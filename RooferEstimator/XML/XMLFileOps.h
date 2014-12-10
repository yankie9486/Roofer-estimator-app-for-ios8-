//
//  XMLFileOps.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoofEstimate.h"
#import "XMLReader.h"

@interface XMLFileOps : NSObject
{
    NSXMLParser *rssParser;
    NSMutableArray *articles;
    
    NSMutableDictionary *item;
    
    NSString *currentElement;
    NSMutableString *ElementValue;
    BOOL errorParsing;
    BOOL fileExists;
}

@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSString *documentsPath;
@property (nonatomic, strong) NSString *filePath;

-(void)saveToXML:(NSMutableArray*)content;
-(NSMutableArray*)LoadXml;
-(BOOL)doesFileExist;

@end
