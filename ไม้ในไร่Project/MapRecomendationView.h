//
//  MapRecomendationView.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/30/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "MapRecomendationView.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PlaceData.h"

@interface MapRecomendationView : ViewController <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationAuthorizationManager;
-(IBAction)setMap:(id)sender;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)SummerMap:(id)sender;
-(IBAction)AllMap:(id)sender;
-(IBAction)RainyMap:(id)sender;
-(IBAction)ColdMap:(id)sender;

@end
