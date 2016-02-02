//
//  AllSeasonViewController.h
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/13/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "UIkit/Uikit.h"
#import "SWRevealViewController.h"


@class AllSeasonTreeDetails;

@interface AllSeasonViewController : ViewController <UITableViewDelegate, UITableViewDataSource,SWRevealViewControllerDelegate>{
    AllSeasonTreeDetails *detailView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) AllSeasonTreeDetails *detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)AllMap:(id)sender;
-(IBAction)ARView:(id)sender;
-(IBAction)AllSearch:(id)sender;



@end
