//
//  RecomendationViewController.h
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/13/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "UIkit/Uikit.h"
#import "SWRevealViewController.h"


@class RecomendationTreeDetails;

@interface RecomendationViewController : ViewController <UITableViewDelegate, UITableViewDataSource,SWRevealViewControllerDelegate>{
    RecomendationTreeDetails *detailView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) RecomendationTreeDetails *detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)RecomendationMap:(id)sender;
-(IBAction)ARView:(id)sender;
-(IBAction)RecomendationSearch:(id)sender;

@end
