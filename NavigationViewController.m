//
//  NavigationViewController.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/12/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "NavigationViewController.h"
#import "MapViewController.h"
#import "SWRevealViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PRARViewController.h"
#import "RecomendationViewController.h"
#import "AllSeasonViewController.h"
#import "SummerViewController.h"
#import "RainyViewController.h"
#import "ColdViewController.h"
#import "AboutViewController.h"




@interface NavigationViewController ()

@end

@implementation NavigationViewController{
    NSArray *menu;
    CLLocationManager *locationManager;
}


@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    // 3gSetting
    // offlineSetting
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = @[@"first",@"second",@"third",@"fourth", @"fifth", @"six" ,@"seven", @"eight",@"nine",@"ten"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [menu count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 0){
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                     bundle:nil];
        RecomendationViewController *controller = (RecomendationViewController *)[sb instantiateViewControllerWithIdentifier:@"RecomendationList"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        
        [navController pushViewController:controller animated:NO];
        
        [self.revealViewController revealToggleAnimated:YES];
        
    }else if(indexPath.row == 1){
        
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                     bundle:nil];
        AllSeasonViewController *controller = (AllSeasonViewController *)[sb instantiateViewControllerWithIdentifier:@"AllSeasonList"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        
        [navController pushViewController:controller animated:NO];
        
        [self.revealViewController revealToggleAnimated:YES];
    }else if(indexPath.row == 2){
        
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                     bundle:nil];
        SummerViewController *controller = (SummerViewController *)[sb instantiateViewControllerWithIdentifier:@"SummerList"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        
        [navController pushViewController:controller animated:NO];
        
        [self.revealViewController revealToggleAnimated:YES];
        
    }else if (indexPath.row == 3){
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                     bundle:nil];
        RainyViewController *controller = (RainyViewController *)[sb instantiateViewControllerWithIdentifier:@"RainyList"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        
        [navController pushViewController:controller animated:NO];
        
        [self.revealViewController revealToggleAnimated:YES];
        
    }else if(indexPath.row == 4){
        
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                     bundle:nil];
       ColdViewController *controller = (ColdViewController *)[sb instantiateViewControllerWithIdentifier:@"ColdList"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        
        [navController pushViewController:controller animated:NO];
        
        [self.revealViewController revealToggleAnimated:YES];
    
    
    }else if(indexPath.row ==  5){
        //MapViewController *controller = [[MapViewController alloc] init];
        
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                      bundle:nil];
        MapViewController *controller = (MapViewController *)[sb instantiateViewControllerWithIdentifier:@"Map"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        
        [navController pushViewController:controller animated:NO];
        
        [self.revealViewController revealToggleAnimated:YES];
    }else if (indexPath.row == 6){
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                      bundle:nil];
        PRARViewController *ARcontroller = (PRARViewController *)[sb instantiateViewControllerWithIdentifier:@"ARNew"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController pushViewController:ARcontroller animated:NO];
        
        
        [self.revealViewController revealToggleAnimated:YES];
    }else if(indexPath.row == 8){
        
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main"
                                                     bundle:nil];
        AboutViewController *controller = (AboutViewController *)[sb instantiateViewControllerWithIdentifier:@"About"];
        
        UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
        
        [navController pushViewController:controller animated:NO];
        
        [self.revealViewController revealToggleAnimated:YES];
        
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    
    NSString *sidebarName = @"";
    
    switch (indexPath.row) {
        case 0:{
            sidebarName = @"sidebar_Recommended_Tree";
            break;
        }
            
        case 1:{
            sidebarName = @"sidebar_all_season";
            
            break;
        }
        
        case 2:{
            sidebarName = @"sidebar_Summer_Season";
            
            break;
        }
        
        case 3:{
            sidebarName = @"sidebar_Rainy_Season";
            
            break;
        }
        
        case 4:{
            sidebarName = @"sidebar_Cold_Season";
            break;
        }
            
        case 5:{
            sidebarName = @"sidebar_map_label";
            break;
        }
            
        case 6:{
            sidebarName = @"sidebar_ar_label";
            break;
        }
        
        case 7:{
            sidebarName = @"sidebar_setting_header";
            break;
        }
        
        case 8:{
            sidebarName = @"sidebar_setting_about";
            break;
        }
        
        case 9:{
            sidebarName = @"sidebar_setting_language";
            
            UISegmentedControl *langSegmented = (UISegmentedControl *)[cell viewWithTag:2];
            
            [langSegmented addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
            
            if([lang isEqualToString:@"th"]){
                [langSegmented setSelectedSegmentIndex: 0];
            }else{
                [langSegmented setSelectedSegmentIndex: 1];
            }
            break;
        }
        
        case 10:{
            sidebarName = @"sidebar_location_service";
            break;
        }
        default:
            break;
    }
    
    
    titleLabel.text = NSLocalizedStringFromTableInBundle(sidebarName, nil, localBundle, nil);
    
    return cell;
}
- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    if (selectedSegment == 0) {
        if(![lang isEqualToString:@"th"]){
            //LocalizationSetLanguage(data.name);
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"th", nil] forKey:@"AppleLanguages"];
            [tableView reloadData];
            
        }
    }else{
        if(![lang isEqualToString:@"en"]){
            //LocalizationSetLanguage(data.name);
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"en", nil] forKey:@"AppleLanguages"];
            [tableView reloadData];
            
        }
    }
}
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue isKindOfClass:[SWRevealViewControllerSegue class]]){
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc){
            
            UINavigationController *navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers:@[dvc] animated: NO];
            
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            
        };
    }
}
 */


@end
