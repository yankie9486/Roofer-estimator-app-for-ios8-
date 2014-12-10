//
//  RoofDetailScrollView.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoofDetailScrollView;

@protocol RoofDetailScrollViewDelegate <NSObject>

-(void)TouchScreen:(RoofDetailScrollView*)roofDetailSV;

@end

@interface RoofDetailScrollView : UIScrollView


@property (weak) id<RoofDetailScrollViewDelegate> delegateRD;

@end