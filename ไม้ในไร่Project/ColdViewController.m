//
//  ColdViewController.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/13/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "ColdViewController.h"
#import "ColdTreeDetails.h"
#import "SWRevealViewController.h"
#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"
#import "Reachability.h"
#import "PreferencesManager.h"
#import "ColdSearch.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "UIImageView+WebCache.h"
#import "DataUtilEng.h"
#import "MapColdView.h"
#import "ColdSearch.h"
#import "PRARViewController.h"

@interface ColdViewController ()

@end

@implementation ColdViewController{
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

-(void)ColdSearch:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    ColdSearch *coldSearch= (ColdSearch *)[sb instantiateViewControllerWithIdentifier:@"SearchColdList"];
    coldSearch.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:coldSearch animated:YES];
}

-(void)ColdMap:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    MapColdView *MapCold= (MapColdView*)[sb instantiateViewControllerWithIdentifier:@"MapCold"];
    MapCold.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:MapCold animated:YES];
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
        tableData = util.getColdData;
        }else if([language isEqualToString:@"en" ]){
            
            // Load data
            DataUtilEng *util = [[DataUtilEng alloc] init];
            tableData = util.getEngColdData;
        }
        appPrefs = [PreferencesManager sharedInstance];
    }
  
   
    
    self.revealViewController.delegate = self;
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y - 45, tableView.frame.size.width, tableView.frame.size.height + 45);
    ////NSLog(@"ViewDidAppear");
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    
    TitleField.text = NSLocalizedStringFromTableInBundle(@"title_cold_tree", nil, localBundle, nil);
    TitleField.font = [UIFont fontWithName:@"Anchan" size:27];
    TitleField.textColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(70/255.0) green:(130/255.0) blue:(180/255.0) alpha:1.0]];
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
    self.detailView = (ColdTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"ColdView"];
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
