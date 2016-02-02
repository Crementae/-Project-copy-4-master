//
//  RainyTreeDetails.m
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/19/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "RainyTreeDetails.h"
#import "MapLocation.h"
#import "PlaceData.h"
#import "RainyGallery.h"
#import "Reachability.h"
#import "PreferencesManager.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "UIImageView+WebCache.h"


@interface RainyTreeDetails ()

@property (nonatomic, strong) NSMutableArray *pageImages;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *LocalName;
@property (weak, nonatomic) IBOutlet UILabel *scientificNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error;



@end


@implementation RainyTreeDetails{
    PreferencesManager *appPrefs;
}

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;


@synthesize data;




@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize imageView3 = _imageView3;
@synthesize imageView4 = _imageView4;
@synthesize imageView5 = _imageView5;


-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}




- (void)viewDidLoad {
    
    
    UIBarButtonItem * newBackButton = [[UIBarButtonItem alloc] initWithTitle:(@"Back") style:UIBarButtonItemStyleBordered target:self action:@selector(Back:)];
    [newBackButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    [super viewDidLoad];
    
    _nameLabel.text = data.name;
    _LocalName.text = [NSString stringWithFormat:@"%@%@", NSLocalizedStringFromTableInBundle(@"LocalName", nil, localBundle, nil), data.local_name];
    _scientificNameLabel.text = [NSString stringWithFormat:@"%@%@", NSLocalizedStringFromTableInBundle(@"view_sci_name", nil, localBundle, nil), data.scientific_name];
    _familyNameLabel.text = [NSString stringWithFormat:@"%@%@", NSLocalizedStringFromTableInBundle(@"view_fam_name", nil, localBundle, nil), data.family_name ];
    
    NSString *baseString = [NSString stringWithFormat:@"%@%@",NSLocalizedStringFromTableInBundle(@"detail", nil, localBundle, nil),data.detail];
    
    NSString * AllDetail = [baseString stringByAppendingFormat:[NSString stringWithFormat:@"\n\n%@%@", NSLocalizedStringFromTableInBundle(@"benefit", nil, localBundle, nil),data.benefit]];
    
    _detailTextView.editable = false;
    _detailTextView.text = AllDetail;
    [_detailTextView flashScrollIndicators];
    
    _detailTextView.backgroundColor = [UIColor clearColor];
    
    _imageView1 = [[UIImageView alloc] init];
    _imageView2 = [[UIImageView alloc] init];;
    _imageView3 = [[UIImageView alloc] init];
    _imageView4 = [[UIImageView alloc] init];
    _imageView5 = [[UIImageView alloc] init];
    
    
    
    
    if (![self connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found" message:@"Please check your network setting!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
        
        
        
        
        
        if([data.gallery count]==1){
            [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[0]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView1.image, nil];
            
            
            
        }else if([data.gallery count] == 2){
            
            [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[0]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[1]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView1.image, _imageView2.image,nil];
            
            
            
        }else if ([data.gallery count ] == 3){
            
            [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[0]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[1]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            
            [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[2]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView1.image, _imageView2.image, _imageView3.image,nil];
            
            
            
        }else if([data.gallery count ]==4){
            
            
            [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[0]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[1]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            
            [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[2]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            [_imageView4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[3]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView1.image, _imageView2.image, _imageView3.image, _imageView4.image,nil];
            
        }else if([data.gallery count ]==5){
            
            [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[0]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[1]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            
            [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[2]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            [_imageView4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[3]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            [_imageView5 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", data.gallery[4]]] placeholderImage:[UIImage imageNamed:@"1.png"]];
            
            _pageImages = [[NSMutableArray alloc]initWithObjects:_imageView1.image, _imageView2.image, _imageView3.image, _imageView4.image, _imageView5.image,nil];
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
-(void)viewDidLayoutSubviews{
    [_detailTextView setContentOffset:CGPointZero animated:NO];
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.pageControl = nil;
}


-(void)Back:(UIBarButtonItem *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}



-(void)actionHandleTapOnImageView:(UITapGestureRecognizer *)sender{

    
    if((int)[[UIScreen mainScreen]bounds].size.height==480){
        
        //for iphone 4
        
        UIImageView *imageView = (UIImageView *)sender.view;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"                                                 bundle:nil];
        RainyGallery *view = (RainyGallery *)[sb instantiateViewControllerWithIdentifier:@"RainyGalleryViewI4"];
        view.data = data;
        view.imageView1 = _imageView1.image;
        view.imageView2 = _imageView2.image;
        view.imageView3 = _imageView3.image;
        view.imageView4 = _imageView4.image;
        view.imageView5 = _imageView5.image;
        view.index = (imageView.tag - 1);
        
        
        [self.navigationController pushViewController:view animated:YES];
        
    }else if((int)[[UIScreen mainScreen]bounds].size.height==568){
        
        //for iphone 5
        UIImageView *imageView = (UIImageView *)sender.view;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"                                                 bundle:nil];
        RainyGallery *view = (RainyGallery *)[sb instantiateViewControllerWithIdentifier:@"RainyGalleryViewI5"];
        view.data = data;
        view.imageView1 = _imageView1.image;
        view.imageView2 = _imageView2.image;
        view.imageView3 = _imageView3.image;
        view.imageView4 = _imageView4.image;
        view.imageView5 = _imageView5.image;
        view.index = (imageView.tag - 1);
        
        
        [self.navigationController pushViewController:view animated:YES];
        
    }else if((int)[[UIScreen mainScreen]bounds].size.height==667){
        
        //for iphone 6
        UIImageView *imageView = (UIImageView *)sender.view;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"                                                 bundle:nil];
        RainyGallery *view = (RainyGallery *)[sb instantiateViewControllerWithIdentifier:@"RainyGalleryViewI6"];
        view.data = data;
        view.imageView1 = _imageView1.image;
        view.imageView2 = _imageView2.image;
        view.imageView3 = _imageView3.image;
        view.imageView4 = _imageView4.image;
        view.imageView5 = _imageView5.image;
        view.index = (imageView.tag - 1);
        
        
        [self.navigationController pushViewController:view animated:YES];
        
        
        
    }else if((int)[[UIScreen mainScreen]bounds].size.height==736){
        
        //for iphone 6+
        UIImageView *imageView = (UIImageView *)sender.view;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"                                                 bundle:nil];
        RainyGallery *view = (RainyGallery *)[sb instantiateViewControllerWithIdentifier:@"RainyGalleryViewI6+"];
        view.data = data;
        view.imageView1 = _imageView1.image;
        view.imageView2 = _imageView2.image;
        view.imageView3 = _imageView3.image;
        view.imageView4 = _imageView4.image;
        view.imageView5 = _imageView5.image;
        view.index = (imageView.tag - 1);
        
        
        [self.navigationController pushViewController:view animated:YES];
        
        
    }
}
- (IBAction)locationClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    MapLocation *mapView = (MapLocation *)[sb instantiateViewControllerWithIdentifier:@"MapLocation"];
    mapView.data = data;
    
    //mapView.data = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:mapView animated:YES];
}

- (IBAction)facebookClick:(id)sender {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    NSBundle *localBundle = [NSBundle bundleWithPath:path];
    
    if (status != ReachableViaWWAN && status != ReachableViaWiFi)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"msg_no_net_title", nil, localBundle, nil)
                                                        message:NSLocalizedStringFromTableInBundle(@"msg_no_net_msg", nil, localBundle, nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"msg_no_net_ok", nil, localBundle, nil)
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self postFacebook];
}

- (void) postFacebook{
    NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"http://rmfl.nagasoftware.com/view.php?plant_id=%@",data.tree_id]];
    
    NSURL *urlToPicture = [NSURL URLWithString:[NSString stringWithFormat:@"%@",data.tree_id, data.thumbnail]];
    ////NSLog(@"%@",urlToPicture);

    
    NSString *locationStr = @"";
    if([data.locations count] > 0){
        Location *location = data.locations[0];
        locationStr = [NSString stringWithFormat:@"%@,%@",location.lat,location.lng];
    }
    FBLinkShareParams *params = [[FBLinkShareParams alloc] initWithLink:urlToShare
                                                                   name:data.name
                                                                caption:nil
                                                            description:[NSString stringWithFormat:@"%@ %@",data.detail, locationStr]
                                                                picture:urlToPicture];
    
    BOOL isSuccessful = NO;
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        FBAppCall *appCall = [FBDialogs presentShareDialogWithParams:params
                                                         clientState:nil
                                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                                 if (error) {
                                                                     //NSLog(@"Error: %@", error.description);
                                                                 } else {
                                                                     //NSLog(@"Success!");
                                                                 }
                                                             }];
        isSuccessful = (appCall  != nil);
    }
    if (!isSuccessful && [FBDialogs canPresentOSIntegratedShareDialogWithSession:[FBSession activeSession]]){
        // Next try to post using Facebook's iOS6 integration
        isSuccessful = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
                                                                initialText:[NSString stringWithFormat:@"%@ %@",data.name,data.description]
                                                                      image:urlToPicture
                                                                        url:urlToShare
                                                                    handler:nil];
    }
    if (!isSuccessful) {
        [self performPublishAction:^{
            NSString *message = [NSString stringWithFormat:@"Updating status for %@ at %@", self.loggedInUser.first_name, [NSDate date]];
            
            FBRequestConnection *connection = [[FBRequestConnection alloc] init];
            
            connection.errorBehavior = FBRequestConnectionErrorBehaviorReconnectSession
            | FBRequestConnectionErrorBehaviorAlertUser
            | FBRequestConnectionErrorBehaviorRetry;
            
            [connection addRequest:[FBRequest requestForPostStatusUpdate:message]
                 completionHandler:^(FBRequestConnection *innerConnection, id result, NSError *error) {
                     [self showAlert:message result:result error:error];
                     self.fbButton.enabled = YES;
                 }];
            [connection start];
            
            self.fbButton.enabled = NO;
        }];
    }
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}
// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                }
                                                //For this example, ignore errors (such as if user cancels).
                                            }];
    } else {
        action();
    }
    
}

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        // For simplicity, we will use any error message provided by the SDK,
        // but you may consider inspecting the fberrorShouldNotifyUser or
        // fberrorCategory to provide better recourse to users. See the Scrumptious
        // sample for more examples on error handling.
        if (error.fberrorUserMessage) {
            alertMsg = error.fberrorUserMessage;
        } else {
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Success";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


@end