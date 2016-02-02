//
//  MapRainyLocation.m
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/30/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//


#import "MapRainyLocation.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PlaceData.h"
#import "Location.h"
#import "RainyTreeDetails.h"
#import "PreferencesManager.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#import "UIImageView+WebCache.h"

@interface MapRainyLocation ()

@end

@implementation MapRainyLocation{
    PreferencesManager *appPrefs;
}

@synthesize mapView;
@synthesize data;


-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * newBackButton = [[UIBarButtonItem alloc] initWithTitle:(@"Back") style:UIBarButtonItemStyleBordered target:self action:@selector(Back:)];
    [newBackButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    
    
    //20.045127,99.89485
    float defaultLat = 19.902967;
    float defaultLng = 99.794456;
    
    if([data.locations count] > 0){
        Location *location = data.locations[0];
        defaultLat = [location.lat floatValue];
        defaultLng = [location.lng floatValue];
    }
    
    appPrefs = [PreferencesManager sharedInstance];
    
    // Do any additional setup after loading the view.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:defaultLat
                                                            longitude:defaultLng
                                                                 zoom:16];
    
    mapView.camera = camera;
    mapView.delegate = self;
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    
    
}

-(void)Back:(UIBarButtonItem *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [mapView clear];
    

    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
    
    
    NSString *markerPath = [NSString stringWithFormat:@"PinRainny.png"];
    
    int index = 0;
    GMSMarker *tappedMarker = nil;
    for(Location *location in data.locations){
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([location.lat floatValue], [location.lng floatValue]);
        marker.title = data.name;
        marker.infoWindowAnchor = CGPointMake(0.5, 0.5);
        marker.map = mapView;
        
        NSString *currentIndex = [[NSString alloc] initWithFormat:@"%d",index];
        
        marker.snippet = currentIndex;
        marker.icon = [UIImage imageNamed:markerPath];
        index++;
        
        if(tappedMarker == nil){
            tappedMarker = marker;
        }
    }
    
    mapView.selectedMarker = tappedMarker;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    PlaceData *currentMarker = data;
    
    UIView *dialogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 261, 95)];
    
    // Create background image
    UIImageView *dialogBackground = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"MapDialog.png"]];
    [dialogView addSubview:dialogBackground];
    
    UIImageView * thumbnail = [[UIImageView alloc] init];
    
    SDWebImageManager * manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:currentMarker.thumbnail] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    }completed:^(UIImage * image, NSError * error, SDImageCacheType cachedType, BOOL finished,NSURL *imageURL){
        if(image == finished){
            [thumbnail setImage:image];
        }else{
            [thumbnail sd_setImageWithURL:[NSURL URLWithString:currentMarker.thumbnail]  placeholderImage:[UIImage imageNamed:@"1.png"]  completed:^(UIImage * img, NSError *error, SDImageCacheType cachedType, NSURL * imageURL){
                if(!marker.snippet||!cachedType){
                    [marker setSnippet:@""];
                    if(mapView.selectedMarker == marker){
                        [mapView setSelectedMarker:marker];
                    }
                    
                }
            }];
        }
    }];
    
    
    
    
    
    CGRect tmpFrame = thumbnail.frame;
    tmpFrame.origin.x = 15;
    tmpFrame.origin.y = 14;
    tmpFrame.size.width = 55;
    tmpFrame.size.height = 55;
    thumbnail.frame = tmpFrame;
    thumbnail.contentMode = UIViewContentModeScaleToFill;
    [dialogView addSubview:thumbnail];
    
    
    
    // Create title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(74, 20, 147, 25)];
    title.text = currentMarker.name;
    title.font = [UIFont fontWithName:@"browa_0" size:22];
    [dialogView addSubview:title];
    
    // Create description
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(74, 40, 147, 21)];
    description.text = currentMarker.scientific_name;
    description.font = [UIFont fontWithName:@"browa_0" size:18];
    description.textColor = [UIColor grayColor];
    [dialogView addSubview:description];
    
    [dialogView setNeedsDisplay];
    
    return dialogView;
    
}


-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    //[self.navigationController popViewControllerAnimated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    
    Location *currentLocation = data.locations[[marker.snippet intValue]];
    
    RainyTreeDetails *view = (RainyTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"RainyView"];
    view.data = data;
    view.data.locationNumber = [marker.snippet intValue] + 1;
    
    ////NSLog(@"%d",imageView.tag);
    
    //view.index = 0;
    
    [self.navigationController pushViewController:view animated:YES];
}


- (IBAction)setMap:(id)sender {
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
            
        case 0:
        {
            mapView.mapType = kGMSTypeNormal;
            break;
        }
            
        case 1:
        {
            mapView.mapType = kGMSTypeSatellite;
            break;
        }
            
        case 2:
        {
            mapView.mapType = kGMSTypeHybrid;
            break;
        }
    }
}


@end