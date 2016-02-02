//
//  SummerSearch.h
//  ไม้ในไร่Project
//
//  Created by Crementae on 7/21/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@class SummerTreeDetails;

@interface SummerSearch : ViewController<UITableViewDataSource, UITableViewDelegate>{
    SummerTreeDetails *detailView;
}

@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SummerTreeDetails*detailView;
@property (strong, nonatomic)IBOutlet UITextField *TitleField;
-(IBAction)SummerMap:(id)sender;
-(IBAction)ARView:(id)sender;

@end


