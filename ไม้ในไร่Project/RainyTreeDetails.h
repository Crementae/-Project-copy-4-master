//
//  RainyTreeDetails.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/19/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UIKit/Uikit.h"
#import <FacebookSDK/FacebookSDK.h>



@class PlaceData;
@interface RainyTreeDetails :  UIViewController <UIScrollViewDelegate>{
    PlaceData *data;
    BOOL pageControlBeingUsed;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property PlaceData *data;

@property (nonatomic, retain) IBOutlet UIImageView *imageView1;
@property (nonatomic, retain) IBOutlet UIImageView *imageView2;
@property (nonatomic, retain) IBOutlet UIImageView *imageView3;
@property (nonatomic, retain) IBOutlet UIImageView *imageView4;
@property (nonatomic, retain) IBOutlet UIImageView*imageView5;



@property (strong, nonatomic) IBOutlet UIButton *fbButton;



@end