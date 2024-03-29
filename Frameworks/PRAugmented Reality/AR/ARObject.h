//
//  ARObject.h
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

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ARController.h"


#import "ARSettings.h"


@interface ARObject : UIViewController<UINavigationControllerDelegate,UIApplicationDelegate>
{
    
    // ARObject main components
    NSString *arTitle;
    NSString *arSci;
    NSString *arThumb;
    
    
    int arId;
    int arTid;
    double lat;
    double lon;
    NSNumber *distance;
    
    // Overlay View Objects
    IBOutlet UILabel *titleL;
    IBOutlet UILabel *distanceL;
    IBOutlet UILabel *sciL;
    IBOutlet UIImageView *thumbnailL;
}


@property (nonatomic, strong) NSString *arTitle;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic,strong)NSString * arSci;
@property (nonatomic,strong)NSString* arThumb;

-(double)calculateDistanceFrom:(CLLocationCoordinate2D)user_loc_coord;

- (id)initWithId:(int)newId
         tree_id:(int)newTid
           title:(NSString*)newTitle
        sci_name:(NSString *)newSciname
       thumbnail:(UIImageView *)newThumb
     coordinates:(CLLocationCoordinate2D)newCoordinates
andCurrentLocation:(CLLocationCoordinate2D)currLoc;

-(NSString*)getDistanceLabelText;
- (NSDictionary*)getARObjectData;
-(UILabel*)getDistanceL;

@end
