//
//  ColdSearch.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/18/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@class ColdTreeDetails;

@interface ColdSearch : ViewController<UITableViewDataSource, UITableViewDelegate>{
    ColdTreeDetails *detailView;
}

@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) ColdTreeDetails *detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)ColdMap:(id)sender;
-(IBAction)ARView:(id)sender;


@end


