//
//  MapSummerView.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/28/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "MapSummerView.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PlaceData.h"

@interface MapSummerView : ViewController <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationAuthorizationManager;
-(IBAction)setMap:(id)sender;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)AllMap:(id)sender;
-(IBAction)ColdMap:(id)sender;
-(IBAction)RecomendationMap:(id)sender;
-(IBAction)RainyMap:(id)sender;


@end
