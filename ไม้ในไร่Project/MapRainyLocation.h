//
//  MapRainyLocation.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/30/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "PlaceData.h"

@interface MapRainyLocation : UIViewController <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property PlaceData *data;



@end
