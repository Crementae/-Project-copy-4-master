//
//  ViewController.m
//  ARNewTest
//
//  Created by Crementae on 12/12/15.
//  Copyright © 2015 Crementae. All rights reserved.
//

#import "PRARViewController.h"
#import "PRARManager.h"
#import <CoreLocation/CoreLocation.h>
#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"
#import "AllSeasonTreeDetails.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "PreferencesManager.h"
#import "DataUtilEng.h"
#import "ARObject.h"
#import "AllSeasonViewController.h"

@interface PRARViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) PRARManager *prARManager;
@property (nonatomic, strong) CLLocation *detectLocation;

@end


@implementation PRARViewController{
    CLLocationManager *locationManager;
    NSArray *data;
    NSMutableArray *arData;
}
-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (NSMutableArray *)loadData{
 
    NSString *language = [[NSLocale preferredLanguages]objectAtIndex:0];
    
    
  
    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
        if([language isEqualToString:@"th"]){
            // Load data
            DataUtil *util = [[DataUtil alloc] init];
            arData = [[NSMutableArray alloc] init];
            data = util.getData;
            arData = data;
        }else if([language isEqualToString:@"en" ]){
            
            // Load data
            DataUtilEng *util = [[DataUtilEng alloc] init];
            arData = [[NSMutableArray alloc] init];
            data = util.getEngData;
            arData = data;
            
        }
    }
    
    

    
    
    NSMutableArray *temp = [NSMutableArray array];
    int index = 0;
    NSArray *keys = @[@"ar_id",@"tree_id",@"name",@"scientific_name",@"thumbnail", @"lat", @"lng"];
    
    
  
    for(PlaceData *place in data){
        
        /*if(![place.tree_id isEqualToString:@"109"]){
         continue;
         }*/
        
        for(Location *location in place.locations){
            PlaceData *obj = [[PlaceData alloc] init];
            obj.name = place.name;
            obj.locations = place.locations;
            obj.tree_id = place.tree_id;
            obj.detail = place.detail;
            obj.scientific_name = place.scientific_name;
            obj.family_name = place.family_name;
            obj.thumbnail = place.thumbnail;
            obj.gallery = place.gallery;
            obj.currentLocation = location;
             //NSLog(@"%@ %@ %@ %@",place.name, location.lat, location.lng,place.thumbnail);
           
                
            
            NSArray *values = @[
                                [NSString stringWithFormat:@"%d",index],
                                place.tree_id,
                                place.name,
                                place.scientific_name,
                                place.thumbnail,
                                location.lat,
                                location.lng];
            [temp addObject: [NSDictionary dictionaryWithObjects:values forKeys:keys]];
            index++;
            
            }
        
    }
    
    
    
    arData = [temp copy];
    
    return arData;
}


- (void)alert:(NSString*)title withDetails:(NSString*)details {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:details
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * newBackButton = [[UIBarButtonItem alloc] initWithTitle:(@"Back") style:UIBarButtonItemStyleBordered target:self action:@selector(Back:)];
    [newBackButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = newBackButton;
  

    
    self.prARManager = [[PRARManager alloc] initWithSize:self.view.frame.size delegate:self showRadar:YES];
}
-(void)Back:(UIBarButtonItem *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(CLLocationCoordinate2D) getLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    
    
    
    
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count-2];
    } else {
        oldLocation = nil;
    }
   // NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
    
     CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude);
   // NSLog(@"New %f, New2 %f",locationCoordinates.longitude, locationCoordinates.latitude);
    
    NSDictionary * getOb = [self.prARManager.arController getGeoObjectOverlay];
    int count = [[getOb allKeys] count];
   // NSLog(@"%d",count);
    
    for ( int i=1; i <= count;i++) {
        ARObject * lo  =((ARObject*)[getOb objectForKey:[NSNumber numberWithInt:i]]);
       // NSLog(@"Sci %@",((ARObject*)[getOb objectForKey:[NSNumber numberWithInt:i]]).arTitle);
        
        [lo calculateDistanceFrom:locationCoordinates];
        
        [[lo getDistanceL] setText:[lo getDistanceLabelText]];
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSLog(@"Latitude  = %@", latitude);
    NSLog(@"Longitude = %@", longitude);
    
    // Initialize your current location as 0,0 (since it works with our randomly generated locations)
    CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude);
   //CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(19.905768,99.793849);
    
    [self.prARManager startARWithData:[self loadData] forLocation:locationCoordinates];
    
}



- (void)prarDidSetupAR:(UIView *)arView withCameraLayer:(AVCaptureVideoPreviewLayer *)cameraLayer andRadarView:(UIView *)radar{
    [self.view.layer addSublayer:cameraLayer];
    [self.view addSubview:arView];
    
    [self.view bringSubviewToFront:[self.view viewWithTag:AR_VIEW_TAG]];
    
    [self.view addSubview:radar];
}

-(void)prarUpdateFrame:(CGRect)arViewFrame{
    
    [[self.view viewWithTag:AR_VIEW_TAG]setFrame:arViewFrame ];
    
}
-(void)prarGotProblem:(NSString *)problemTitle withDetails:(NSString *)problemDetails{
    [self alert:problemTitle withDetails:problemDetails];
}
@end
