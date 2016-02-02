//
//  AllSeasonViewController.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/13/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "AllSeasonViewController.h"
#import "AllSeasonTreeDetails.h"
#import "SWRevealViewController.h"
#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"
#import "Reachability.h"
#import "PreferencesManager.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "UIImageView+WebCache.h"
#import "DataUtilEng.h"
#import "MapViewController.h"
#import "AllSeasonSearch.h"
#import "PRARViewController.h"



@interface AllSeasonViewController ()

@end

@implementation AllSeasonViewController{
    NSArray *tableData;
    PreferencesManager *appPrefs;
}

@synthesize tableView;
@synthesize detailView;
@synthesize TitleField;



-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(void)AllSearch:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    AllSeasonSearch *allSearch= (AllSeasonSearch *)[sb instantiateViewControllerWithIdentifier:@"SearchAllSeasonList"];
    allSearch.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:allSearch animated:YES];
}

-(void)AllMap:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
   MapViewController *allMapView= (MapViewController*)[sb instantiateViewControllerWithIdentifier:@"Map"];
    allMapView.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:allMapView animated:YES];
}
-(void)ARView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PRARViewController *arView= (PRARViewController *)[sb instantiateViewControllerWithIdentifier:@"ARNew"];
    
    
    
    [self.navigationController pushViewController:arView animated:YES];
}

- (void)viewDidLoad {
    
    
    NSString * language = [[NSLocale preferredLanguages]objectAtIndex:0];
   // //NSLog(@"String %@",language);
    
 
    [super viewDidLoad];
    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
    
  
        

    //Load data
        if([language isEqualToString:@"th"]){
    DataUtil *util = [[DataUtil alloc] init];
    tableData = util.getData;

            
        }else if([language isEqualToString:@"en"]){
            DataUtilEng *util = [[DataUtilEng alloc] init];
            tableData = util.getEngData;
           
        }
            appPrefs = [PreferencesManager sharedInstance];
    }
    
    
    self.revealViewController.delegate = self;
    

  
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
     
}

-(void)viewWillDisappear:(BOOL)animated{
    if([self.navigationController.viewControllers indexOfObject:self]==NSNotFound){
        [self viewDidLoad];
        [self.navigationController popViewControllerAnimated:NO];
    }
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    
    TitleField.text = NSLocalizedStringFromTableInBundle(@"title_all_tree", nil, localBundle, nil);
    TitleField.font = [UIFont fontWithName:@"Anchan" size:27];
    TitleField.textColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(34/255.0) green:(139/255.0) blue:(34/255.0) alpha:1.0]];
    [self.tableView reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
  
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
  
    
    
    cell.tag = indexPath.row;
    [cell setOpaque:NO];
    [cell setBackgroundColor: [UIColor clearColor]];
    
    PlaceData *data = [tableData objectAtIndex:indexPath.row];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *sciNameLabel = (UILabel *)[cell viewWithTag:200];
    UIImageView *thumbnailImageView = (UIImageView *)[cell viewWithTag:300];
    nameLabel.text = data.name;
    sciNameLabel.text = data.scientific_name;
    
    
    
   [thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.thumbnail]] placeholderImage:[UIImage imageNamed:@"noImg.png"]];
    
    return cell;
    
}







- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    PlaceData *data = [tableData objectAtIndex:indexPath.row];
    
    //if([data.gallery count] == 1){
    self.detailView = (AllSeasonTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"AllSeasonView"];
    //}
    self.detailView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.detailView animated:YES];
}
#pragma mark - SWRevealViewController Delegate

-(void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position{
    
    
    if(position == FrontViewPositionLeft){
        [self viewDidLoad];
        //NSLog(@"re");
        [tableView reloadData];
        [self viewWillAppear:YES];
        
        
    }
    
}

@end
