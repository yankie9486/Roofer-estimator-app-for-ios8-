//
//  AddingScrollView.h
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddingScrollView;

@protocol AddingScrollViewDelegate <NSObject>

-(void)TouchScreen:(AddingScrollView*)addingScrollView;

@end

@interface AddingScrollView : UIScrollView

@property (weak) id<AddingScrollViewDelegate>delegateASV;

@end
