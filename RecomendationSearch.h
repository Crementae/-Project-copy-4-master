//
//  RecomendationSearch.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/19/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@class RecomendationTreeDetails;

@interface RecomendationSearch : ViewController<UITableViewDataSource, UITableViewDelegate>{
    RecomendationTreeDetails *detailView;
}

@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) RecomendationTreeDetails *detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)RecomendationMap:(id)sender;
-(IBAction)ARView:(id)sender;

@end


