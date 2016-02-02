
//
//  RecomendationSearch.m
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/19/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "RecomendationSearch.h"
#import "RecomendationTreeDetails.h"
#import "SWRevealViewController.h"
#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"
#import "Reachability.h"
#import "PreferencesManager.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "UIImageView+WebCache.h"
#import "DataUtilEng.h"
#import "MapRecomendationView.h"
#import "PRARViewController.h"

@interface RecomendationSearch ()

@end

@implementation RecomendationSearch{
    
    NSArray *tableData;
    NSArray *tempTableData;
    CGRect tableViewFrame;
    PreferencesManager *appPrefs;
    
}

@synthesize tableView;
@synthesize detailView;
@synthesize searchField;
@synthesize TitleField;



-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(void)RecomendationMap:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    MapRecomendationView *MapRecom= (MapRecomendationView *)[sb instantiateViewControllerWithIdentifier:@"MapRecomendation"];
    MapRecom.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:MapRecom animated:YES];
}
-(void)ARView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PRARViewController *arView= (PRARViewController *)[sb instantiateViewControllerWithIdentifier:@"ARNew"];
    
    
    
    [self.navigationController pushViewController:arView animated:YES];
}


- (void)viewDidLoad {
    
    
    NSString * language = [[NSLocale preferredLanguages]objectAtIndex:0];
        
    [super viewDidLoad];
    
    UIBarButtonItem * newBackButton = [[UIBarButtonItem alloc] initWithTitle:(@"Back") style:UIBarButtonItemStyleBordered target:self action:@selector(Back:)];
    [newBackButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = newBackButton;
  

    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
        if([language isEqualToString:@"th"]){
        // Load data
        DataUtil *util = [[DataUtil alloc] init];
        tableData = util.getRecomendationData;
        tempTableData = tableData;
            
        } else if([language isEqualToString:@"en" ]){
            
            // Load data
            DataUtilEng *util = [[DataUtilEng alloc] init];
            tableData = util.getEngRecomendationData;
            tempTableData = tableData;
        }
        appPrefs = [PreferencesManager sharedInstance];
    }
    
    
    self.searchField.delegate = self;
    
 
}
-(void)viewWillAppear:(BOOL)animated{
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    TitleField.text = NSLocalizedStringFromTableInBundle(@"title_recomendation_tree", nil, localBundle, nil);
    [searchField setPlaceholder: NSLocalizedStringFromTableInBundle(@"search_hint", nil, localBundle, nil)];
    TitleField.font = [UIFont fontWithName:@"Anchan" size:25];
    TitleField.textColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(void)Back:(UIBarButtonItem *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y - 45, tableView.frame.size.width, tableView.frame.size.height + 45);
    ////NSLog(@"ViewDidAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tempTableData count];
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
    
    PlaceData *data = [tempTableData objectAtIndex:indexPath.row];
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
    self.detailView = (RecomendationTreeDetails *)[sb instantiateViewControllerWithIdentifier:@"RecomendationView"];
    //}
    self.detailView.data = [tempTableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.detailView animated:YES];
}


-(void)updateTableView:(BOOL)isSearch{
    if(isSearch == false){ // Up
        tableView.frame = CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y, tableViewFrame.size.width, tableViewFrame.size.height);
    }else if(isSearch == true){ // Down
        tableView.frame = CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y + 45, tableViewFrame.size.width, tableViewFrame.size.height - 45);
    }
}

- (IBAction)filterTree:(id)sender {
    if(searchField.text.length == 0){
        tempTableData = tableData;
    }else{
        NSMutableArray *temp = [NSMutableArray arrayWithArray:tableData];
        NSString *keyword = [NSString stringWithFormat:@"*%@*",searchField.text];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name LIKE[c] %@",keyword];
        tempTableData = [NSMutableArray arrayWithArray:[temp filteredArrayUsingPredicate:predicate]];
    }
    //[self updateTableView:true];
    [tableView reloadData];
    //[searchField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end