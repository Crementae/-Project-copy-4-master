//
//  MapSummerFilterController.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/28/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface MapSummerFilterController : ViewController <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
@end