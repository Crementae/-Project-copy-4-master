//
//  MapColdFilterController.m
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/29/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "MapColdFilterController.h"
#import "ColdTreeDetails.h"
#import "MapColdView.h"
#import <GoogleMaps/GoogleMaps.h>
#import "DataUtil.h"
#import "PlaceData.h"
#import "PreferencesManager.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "DataUtilEng.h"
#import "UIImageView+WebCache.h"



@interface MapColdFilterController ()

@end

@implementation MapColdFilterController{
    NSArray *tableData;
    PreferencesManager *appPrefs;
}

@synthesize mapView;
@synthesize searchTextField;
@synthesize TitleField;


-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}



- (void)viewDidLoad {
    
    NSString *language = [[NSLocale preferredLanguages]objectAtIndex:0];
    
    [super viewDidLoad];
    
    UIBarButtonItem * newBackButton = [[UIBarButtonItem alloc] initWithTitle:(@"Back") style:UIBarButtonItemStyleBordered target:self action:@selector(Back:)];
    [newBackButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    appPrefs = [PreferencesManager sharedInstance];
    
    
    
    // Do any additional setup after loading the view.
    //20.045127,99.89485
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:19.902967
                                                            longitude:99.794456
                                                                 zoom:16];
    
    mapView.camera = camera;
    mapView.delegate = self;
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    

    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
        if([language isEqualToString:@"th"]){
        
        //Load data
        DataUtil *util = [[DataUtil alloc] init];
        tableData = util.getColdData;
            
        }else if([language isEqualToString:@"en"]){
            
            //Load data
            DataUtilEng *util = [[DataUtilEng alloc] init];
            tableData = util.getEngColdData;
        }
        
    }
    
    
    self.searchTextField.delegate = self;
    
}

-(void)Back:(UIBarButtonItem *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    [searchTextField setPlaceholder: NSLocalizedStringFromTableInBundle(@"search_hint", nil, localBundle, nil)];
    
    TitleField.text = NSLocalizedStringFromTableInBundle(@"title_cold_tree", nil, localBundle, nil);
    TitleField.font = [UIFont fontWithName:@"Anchan" size:27];
    TitleField.textColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(70/255.0) green:(130/255.0) blue:(180/255.0) alpha:1.0]];
    [self loadMarker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)searchBarItemAction:(id)sender{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    ViewController *viewController = (MapColdView *)[sb instantiateViewControllerWithIdentifier:@"MapCold"];
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)loadMarker{
    [mapView clear];
    NSMutableArray *tempTableData = tableData;
    
    if(searchTextField.text.length > 0){
        NSMutableArray *temp = [NSMutableArray arrayWithArray:tableData];
        NSString *keyword = [NSString stringWithFormat:@"*%@*",searchTextField.text];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name LIKE[c] %@",keyword];
        tempTableData = [NSMutableArray arrayWithArray:[temp filteredArrayUsingPredicate:predicate]];
    }
    
    for(PlaceData *data in tempTableData){
        /*if(searchTextField.text.length != 0
         && [data.name rangeOfString:searchTextField.text].location == NSNotFound){
         continue;
         }*/
        
        NSString *markerPath = [NSString stringWithFormat:@"PinCool.png"];
        
        int number = 1;
        for(Location *location in data.locations){
            // Creates a marker in the center of the map.
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([location.lat floatValue], [location.lng floatValue]);
            
            NSString *code = [[NSString alloc] initWithFormat:@"%@-%d",data.name,number];
            
            marker.title = code;
            marker.infoWindowAnchor = CGPointMake(0.5, 0.5);
            marker.map = mapView;
            marker.icon = [UIImage imageNamed:markerPath];
            number++;
        }
    }
}

-(PlaceData *) findDataByMarker:(GMSMarker *)marker{
    PlaceData *currentMarker = nil;
    
    for(PlaceData *data in tableData){
        NSArray *code = [marker.title componentsSeparatedByString: @"-"];
        
        if([code[0] isEqualToString:data.name]){
            currentMarker = data;
            currentMarker.locationNumber = [code[1] intValue];
            break;
        }
    }
    return currentMarker;
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    PlaceData *currentMarker = [self findDataByMarker:marker];
    
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
    
    PlaceData *data = [self findDataByMarker:marker];
    ColdTreeDetails *detailView = [[ColdTreeDetails alloc] init];
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    
    
    detailView = (ColdTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"ColdView"];
    
    
    detailView.data = data;
    [self.navigationController pushViewController:detailView animated:YES];
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

- (IBAction)filterTree:(id)sender {
    [self loadMarker];
    /*
     if(searchField.text.length == 0){
     tempTableData = tableData;
     }else{
     NSMutableArray *temp = [NSMutableArray arrayWithArray:tableData];
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@",searchField.text];
     tempTableData = [NSMutableArray arrayWithArray:[temp filteredArrayUsingPredicate:predicate]];
     }
     //[self updateTableView:true];
     [tableView reloadData];
     //[searchField becomeFirstResponder];
     */
}

-(void)dismissKeyboard {
    [searchTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end