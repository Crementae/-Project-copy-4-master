//
//  ARObject.m
//  PrometAR
//
// Created by Geoffroy Lesage on 4/24/13.
// Copyright (c) 2013 Promet Solutions Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "ARObject.h"
#import "UIImageView+WebCache.h"
#import "PlaceData.h"
#import "AllSeasonTreeDetails.h"
#import "AllSeasonViewController.h"
#import "Reachability.h"
#import "PlaceData.h"
#import "DataUtil.h"
#import "DataUtilEng.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "PreferencesManager.h"
#import "ARController.h"

@interface ARObject ()

@end


@implementation ARObject{
      NSArray *data;
    
}

@synthesize arTitle, distance;



- (id)initWithId:(int)newId
         tree_id:(int)newTid
           title:(NSString*)newTitle
        sci_name:(NSString *)newSciname
        thumbnail:(UIImageView *)newThumb
     coordinates:(CLLocationCoordinate2D)newCoordinates
andCurrentLocation:(CLLocationCoordinate2D)currLoc;
{
    self = [super init];
    if (self) {
        arId = newId;
        arTid = newTid;
        arTitle = [[NSString alloc] initWithString:newTitle];
        arSci = [[NSString alloc]initWithString:newSciname];
        arThumb = [[NSString alloc]initWithString:newThumb];
        
        lat = newCoordinates.latitude;
        lon = newCoordinates.longitude;
        
        @([self calculateDistanceFrom:currLoc]);
        
      
        
        [self.view setTag:newId];
        
       // NSLog(@"Tree_id %d",arTid);
    }
    return self;
}

-(void)calculateDistanceFrom:(CLLocationCoordinate2D)user_loc_coord
{   //NSLog(@" %f, %f",user_loc_coord.longitude, user_loc_coord.latitude);
    CLLocationCoordinate2D object_loc_coord = CLLocationCoordinate2DMake(lat, lon);
    //NSLog(@" %f, %f",object_loc_coord.longitude, object_loc_coord.latitude);
    CLLocation *object_location = [[CLLocation alloc] initWithLatitude:object_loc_coord.latitude
                                                             longitude:object_loc_coord.longitude];
    CLLocation *user_location = [[CLLocation alloc] initWithLatitude:user_loc_coord.latitude
                                                           longitude:user_loc_coord.longitude];
    
      distance = @([object_location distanceFromLocation:user_location]);
}
-(NSString*)getDistanceLabelText
{
    if (distance.doubleValue > ONE_KM_METERS)
        return [NSString stringWithFormat:@"%.2f km", distance.doubleValue*METERS_TO_KM];
    else return [NSString stringWithFormat:@"%.0f m", distance.doubleValue*METERS_TO_METERS];
}

- (NSDictionary*)getARObjectData
{
    NSArray *keys = @[@"ar_id",@"tree_id",@"name",@"scientific_name",@"thumbnail", @"latitude", @"longitude", @"distance"];
    
    NSArray *values = @[@(arId),
                        @(arTid),
                        arTitle,
                        arSci,
                        arThumb,
                        @(lat),
                        @(lon),
                        distance];
    
       return [NSDictionary dictionaryWithObjects:values forKeys:keys];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  

    
    
    [thumbnailL sd_setImageWithURL:[NSURL URLWithString:[arThumb stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"noImg.png"]];

    
    
    [titleL setText:arTitle];
    [sciL setText:arSci];
   

    
    [distanceL setText:[self getDistanceLabelText]];
    
}
-(UILabel*)getDistanceL{
    return distanceL;
}

-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}
- (void) viewDidLoad{
    
    NSString *language = [[NSLocale preferredLanguages]objectAtIndex:0];
    
    
    [super viewDidLoad];
    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        if([language isEqualToString:@"th"]){
            //Load data
            DataUtil *util = [[DataUtil alloc] init];
            data = util.getData;
        }else if([language isEqualToString:@"en" ]){
            
            //Load data
            DataUtilEng *util = [[DataUtilEng alloc] init];
            data = util.getEngData;
        }
    }
    
    
    self.view.userInteractionEnabled = YES;
    
    //The setup code (in viewDidLoad in your view controller)
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    [singleFingerTap setNumberOfTapsRequired:1];
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    /*
    [self viewDidLoad];
    
    [self viewDidAppear:YES];
    [self.view setNeedsLayout];
    [self.view setNeedsDisplay];
    [self.view setNeedsUpdateConstraints];
    
    
    
    NSLog(@"Reload");
    */
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)sender {
    
   

    /*
    
     AllSeasonTreeDetails *detailView = [[AllSeasonTreeDetails alloc] init];
     
     UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
     bundle:nil];
     
     
     detailView = (AllSeasonTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"AllSeasonView"];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:detailView];
    
    for(PlaceData *place in data){
        NSLog(@"ARTid: %d , %@",arTid, place.tree_id);
        
        
        if (arTid == [place.tree_id intValue]) {
            detailView.data = place; break;
            
            
           
        }
    }
    */
  

    
    //[self.navigationController pushViewController:detailView animated:YES];
    //[self presentViewController:navigationController animated:YES completion:nil];
 
  
    
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
        */
    
   
}


#pragma mark -- OO Methods

- (NSString *)description {
    return [NSString stringWithFormat:@"ARObject %d - %@ - %@ - %@ -lat: %f - lon: %f - distance: %@",
            arId, arTitle,arSci,arThumb, lat, lon, distance];
}

@end
