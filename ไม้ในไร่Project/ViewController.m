//
//  ViewController.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/12/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "RecomendationViewController.h"
#import "RecomendationTreeDetails.h"
#import "RecomendationGallery.h"
#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"
#import "Reachability.h"
#import "PreferencesManager.h"
#import "MapViewController.h"
#import "AllSeasonViewController.h"
#import "SummerViewController.h"
#import "RainyViewController.h"
#import "ColdViewController.h"
#import "UIImageView+WebCache.h"
#import "PRARViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

@end

@implementation ViewController{
    PreferencesManager *appPrefs;
    NSArray *picData;
}

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;
@synthesize image = _image;
@synthesize imageView = _imageView;
@synthesize data;
@synthesize TitleField;




-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}



- (void)viewDidLoad {
    
    
    //Load data
    DataUtil *util = [[DataUtil alloc] init];
    picData = util.getRecomendationData;
    appPrefs = [PreferencesManager sharedInstance];
    
    

    
    [super viewDidLoad];

    [self.scroller setScrollEnabled:YES];
    
    
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
        _imageView = [[UIImageView alloc]init];
        UIImageView * imageView1= [[UIImageView alloc]init];
        UIImageView * imageView2 = [[UIImageView alloc]init];
        UIImageView * imageView3 = [[UIImageView alloc]init];
        UIImageView * imageView4 = [[UIImageView alloc]init];
        
        
        if(picData.count >4){
         
            
            PlaceData * data  = [picData objectAtIndex:0];
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData * data1 = [picData objectAtIndex:1];
            
            [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data1.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData * data2 = [picData objectAtIndex:2];
            
            [imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data2.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData* data3 = [picData objectAtIndex:3];
            
            [imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data3.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData* data4 = [picData objectAtIndex:4];
            
            [imageView4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data4.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            //NSLog(@"No data");
            
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView.image,imageView1.image,imageView2.image,imageView3.image,imageView4.image, nil];
       
        }else if(picData.count >3){
            
            PlaceData * data  = [picData objectAtIndex:0];
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData * data1 = [picData objectAtIndex:1];
            
            [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data1.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData * data2 = [picData objectAtIndex:2];
            
            [imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data2.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData* data3 = [picData objectAtIndex:3];
            
            [imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data3.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            

            
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView.image,imageView1.image,imageView2.image,imageView3.image, nil];
            
        }else if(picData.count >2){
           
            PlaceData * data  = [picData objectAtIndex:0];
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData * data1 = [picData objectAtIndex:1];
            
            [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data1.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData * data2 = [picData objectAtIndex:2];
            
            [imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data2.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
           
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView.image,imageView1.image,imageView2.image,nil];
           
           
        }else if(picData.count >1){
            PlaceData * data  = [picData objectAtIndex:0];
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            PlaceData * data1 = [picData objectAtIndex:1];
            
            [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data1.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
        
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView.image,imageView1.image, nil];
           
       }else if(picData.count >0){
           
           PlaceData * data  = [picData objectAtIndex:0];
           
           [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.thumbnail]] placeholderImage:[UIImage imageNamed:@"1.png"]];
           
           _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView.image, nil];
           
       }
        
  
          for (int i = 0; i < _pageImages.count; i++) {
            
            CGRect frame;
            frame.origin.x = self.scrollView.frame.size.width * i;
            frame.origin.y = 0;
            frame.size = self.scrollView.frame.size;
            
            UIImageView *subview = [[UIImageView alloc] initWithFrame:frame];
            subview.contentMode = UIViewContentModeScaleAspectFit;
            
            
            
            [subview setImage:[_pageImages objectAtIndex:i]];
            
            subview.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *SingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionHandleTapOnImageView:)];
            [SingleTap setNumberOfTapsRequired:1];
            
            [subview addGestureRecognizer:SingleTap];
            
            [_scrollView addSubview:subview];
            
                     
            
        }
        
        
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _pageImages.count, self.scrollView.frame.size.height);
        
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = _pageImages.count;
    }
     self.revealViewController.delegate = self;
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        
        
        self.pageControl.currentPage = page;
        
        
        
    }
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    pageControlBeingUsed = NO;
}

- (IBAction)changePage {
    // Update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    
    // Keep track of when scrolls happen in response to the page control
    // value changing. If we don't do this, a noticeable "flashing" occurs
    // as the the scroll delegate will temporarily switch back the page
    // number.
    pageControlBeingUsed = YES;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scroller setScrollEnabled:YES];
    [self.scroller setShowsHorizontalScrollIndicator:NO];
    [self.scroller setShowsVerticalScrollIndicator:NO];
}
-(void)actionHandleTapOnImageView:(UITapGestureRecognizer *)sender{
    UIImageView *imageView = (UIImageView *)sender.view;
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
   
    RecomendationViewController *RecomendationView= (RecomendationViewController *)[sb instantiateViewControllerWithIdentifier:@"RecomendationList"];
    RecomendationView.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:RecomendationView animated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[_scrollView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self viewDidLoad];
    //NSLog(@"refresh");
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.pageControl = nil;
}


- (void)viewWillAppear:(BOOL)animated {
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    TitleField.text = NSLocalizedStringFromTableInBundle(@"title_main", nil, localBundle, nil);
    TitleField.font = [UIFont fontWithName:@"Anchan" size:24];
    TitleField.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(218/255.0) green:(165/255.0) blue:(32/255.0) alpha:1.0]];
    [super viewWillAppear:animated];
    
   
}




-(void)Map:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    MapViewController *allMapView= (MapViewController*)[sb instantiateViewControllerWithIdentifier:@"Map"];
    allMapView.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:allMapView animated:YES];
}
-(void)AR:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    PRARViewController *arView= (PRARViewController *)[sb instantiateViewControllerWithIdentifier:@"ARNew"];
    
    
    
    [self.navigationController pushViewController:arView animated:YES];
}
-(void)AllMap:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    MapViewController *allMapView= (MapViewController*)[sb instantiateViewControllerWithIdentifier:@"Map"];
    allMapView.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:allMapView animated:YES];
}
-(void)AllSeasonView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    AllSeasonViewController *allView= (AllSeasonViewController *)[sb instantiateViewControllerWithIdentifier:@"AllSeasonList"];
    allView.data = data;
    
    
    [self.navigationController pushViewController:allView animated:YES];
}

-(void)HotSeasonView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    SummerViewController *hotView= (SummerViewController*)[sb instantiateViewControllerWithIdentifier:@"SummerList"];
    hotView.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:hotView animated:YES];
}
-(void)RainySeasonView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
   RainyViewController *rainyView= (RainyViewController *)[sb instantiateViewControllerWithIdentifier:@"RainyList"];
    rainyView.data = data;
    
    
    [self.navigationController pushViewController:rainyView animated:YES];
}
-(void)ColdSeasonView:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    ColdViewController *coldView= (ColdViewController *)[sb instantiateViewControllerWithIdentifier:@"ColdList"];
    coldView.data = data;
    
    
    [self.navigationController pushViewController:coldView animated:YES];
}
#pragma mark - SWRevealViewController Delegate

-(void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position{
    
    
    if(position == FrontViewPositionLeft){
        [self viewDidLoad];
        [self viewWillAppear:YES];
        
        
    }
    
}


@end
