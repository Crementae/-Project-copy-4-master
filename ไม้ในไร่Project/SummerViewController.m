//
//  SummerViewController.m
//  ไม้ในไร่Project
//
//  Created by Crementae on 9/12/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "SummerViewController.h"
#import "SummerTreeDetails.h"
#import "SWRevealViewController.h"
#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"
#import "Reachability.h"
#import "PreferencesManager.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "UIImageView+WebCache.h"
#import "DataUtilEng.h"
#import "MapSummerView.h"
#import "PRARViewController.h"
#import "SummerSearch.h"



@interface SummerViewController ()

@end

@implementation SummerViewController{
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
-(void)SummerSearch:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    SummerSearch *summerSearch= (SummerSearch *)[sb instantiateViewControllerWithIdentifier:@"SearchSummerList"];
    summerSearch.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:summerSearch animated:YES];
}

-(void)SummerMap:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    MapSummerView *summerView= (MapSummerView *)[sb instantiateViewControllerWithIdentifier:@"MapSummer"];
    summerView.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:summerView animated:YES];
}
-(void)ARView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PRARViewController *arView= (PRARViewController *)[sb instantiateViewControllerWithIdentifier:@"ARNew"];
    
    
    
    [self.navigationController pushViewController:arView animated:YES];
}

- (void)viewDidLoad {
    
    NSString *language =[[NSLocale preferredLanguages]objectAtIndex:0];
    
    [super viewDidLoad];
    
    
    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
        if([language isEqualToString:@"th" ]){
        // Load data
        DataUtil *util = [[DataUtil alloc] init];
        tableData = util.getHotData;
 
        }else if([language isEqualToString:@"en" ]){
            
            // Load data
            DataUtilEng *util = [[DataUtilEng alloc] init];
            tableData = util.getEngHotData;
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
    
    
    TitleField.text = NSLocalizedStringFromTableInBundle(@"title_summer_tree", nil, localBundle, nil);
    TitleField.font = [UIFont fontWithName:@"Anchan" size:27];
    TitleField.textColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(255/255.0) green:(140/255.0) blue:(0/255.0) alpha:1.0]];
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
    self.detailView = (SummerTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"SummerView"];
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
