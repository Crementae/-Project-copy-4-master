//
//  AboutViewController.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratnakun on 3/13/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "AboutViewController.h"
#import "SWRevealViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    UITextView *detailTextView = (UITextView *)[self.view viewWithTag:100];
    
    detailTextView.editable = false;
    detailTextView.backgroundColor = [UIColor clearColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Abouttext" ofType:@"txt"];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    detailTextView.text = data;
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end