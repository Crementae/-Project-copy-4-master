//
//  SummerTreeDetails.h
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 4/16/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/Uikit.h"
#import <FacebookSDK/FacebookSDK.h>


@class PlaceData;
@interface SummerTreeDetails :  UIViewController <UIScrollViewDelegate>{
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
@property (nonatomic, retain) IBOutlet UIImageView *imageView5;



@property (strong, nonatomic) IBOutlet UIButton *fbButton;


@end