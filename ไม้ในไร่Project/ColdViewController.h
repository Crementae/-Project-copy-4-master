//
//  ColdViewController.h
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/13/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "UIkit/Uikit.h"
#import "SWRevealViewController.h"


@class ColdTreeDetails;

@interface ColdViewController : ViewController <UITableViewDelegate, UITableViewDataSource,SWRevealViewControllerDelegate>{
    ColdTreeDetails *detailView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) ColdTreeDetails *detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)ColdMap:(id)sender;
-(IBAction)ARView:(id)sender;
-(IBAction)ColdSearch:(id)sender;



@end
