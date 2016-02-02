//
//  AppDelegate.h
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/12/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ARObject.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) ViewController *viewController;
@property (nonatomic,strong) ARObject *ARController;
@property (nonatomic,strong) UINavigationController *nvController;
@end

