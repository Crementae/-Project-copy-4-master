//
//  RainyViewController.m
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/19/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "RainyViewController.h"
#import "RainyTreeDetails.h"
#import "SWRevealViewController.h"
#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"
#import "Reachability.h"
#import "PreferencesManager.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "UIImageView+WebCache.h"
#import "DataUtilEng.h"
#import "MapRainyView.h"
#import "RainySearch.h"
#import "PRARViewController.h"

@interface RainyViewController ()

@end

@implementation RainyViewController{
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

-(void)RainySearch:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    RainySearch *rainySearch= (RainySearch *)[sb instantiateViewControllerWithIdentifier:@"SearchRainyList"];
    rainySearch.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:rainySearch animated:YES];
}

-(void)RainyMap:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    MapRainyView *MapRainy= (MapRainyView*)[sb instantiateViewControllerWithIdentifier:@"MapRainy"];
    MapRainy.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:MapRainy animated:YES];
}
-(void)ARView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PRARViewController *arView= (PRARViewController *)[sb instantiateViewControllerWithIdentifier:@"ARNew"];
    
    
    
    [self.navigationController pushViewController:arView animated:YES];
}

- (void)viewDidLoad {
  
    NSString * language = [[NSLocale preferredLanguages]objectAtIndex:0];
    [super viewDidLoad];
    

    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        if([language isEqualToString:@"th"]){
            
        // Load data
        DataUtil *util = [[DataUtil alloc] init];
        tableData = util.getRainyData;
        
        }else if([language isEqualToString:@"en"]){
            
            DataUtilEng *util = [[DataUtilEng alloc] init];
            tableData = util.getEngRainyData;
        }
        appPrefs = [PreferencesManager sharedInstance];
    }
    
    
    self.revealViewController.delegate = self;
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    
    TitleField.text = NSLocalizedStringFromTableInBundle(@"title_rainy_tree", nil, localBundle, nil);
    TitleField.font = [UIFont fontWithName:@"Anchan" size:27];
    TitleField.textColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(105/255.0) green:(105/255.0) blue:(105/255.0) alpha:1.0]];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    self.detailView = (RainyTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"RainyView"];
    //}
    self.detailView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.detailView animated:YES];
}
#pragma mark - SWRevealViewController Delegate

-(void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position{
    
    
    if(position == FrontViewPositionLeft){
        [self viewDidLoad];
        [tableView reloadData];
        [self viewWillAppear:YES];
       
        
    }
    
}


@end
