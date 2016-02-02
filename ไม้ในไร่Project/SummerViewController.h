//
//  SummerViewController.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 9/12/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "UIkit/Uikit.h"
#import "SWRevealViewController.h"


@class SummerTreeDetails;

@interface SummerViewController : ViewController <UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate>{
    SummerTreeDetails *detailView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SummerTreeDetails *detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)SummerMap:(id)sender;
-(IBAction)ARView:(id)sender;
-(IBAction)SummerSearch:(id)sender;




@end
