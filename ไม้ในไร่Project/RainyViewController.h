//
//  RainyViewController.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/19/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "UIkit/Uikit.h"
#import "SWRevealViewController.h"

@class RainyTreeDetails;

@interface RainyViewController : ViewController <UITableViewDelegate, UITableViewDataSource,SWRevealViewControllerDelegate>{
    RainyTreeDetails *detailView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) RainyTreeDetails *detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)RainyMap:(id)sender;
-(IBAction)ARView:(id)sender;
-(IBAction)RainySearch:(id)sender;




@end
