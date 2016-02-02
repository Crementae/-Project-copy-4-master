//
//  MapColdView.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/29/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "MapColdView.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PlaceData.h"

@interface MapColdView : ViewController <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationAuthorizationManager;
-(IBAction)setMap:(id)sender;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)SummerMap:(id)sender;
-(IBAction)AllMap:(id)sender;
-(IBAction)RecomendationMap:(id)sender;
-(IBAction)RainyMap:(id)sender;

@end
