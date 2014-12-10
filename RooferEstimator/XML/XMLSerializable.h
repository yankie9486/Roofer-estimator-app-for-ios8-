//
//  XMLStreamWriter.h
//  xswi
//
//  Created by Thomas Skjølberg on 9/24/10.
//  Copyright 2010 Adactus. All rights reserved.

#import "XMLWriter.h"

@protocol XMLSerializable

- (void) write:(id<XMLStreamWriter>)writer;

@end
