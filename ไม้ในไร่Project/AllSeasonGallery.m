//
//  AllSeasonGallery.m
//  ไม้ในไร่Project
//
//  Created by Crementae on 8/19/15.
//  Copyright (c) 2015 Adisorn Chatnartanakun. All rights reserved.
//

#import "AllSeasonGallery.h"
#import "PlaceData.h"

@interface AllSeasonGallery ()

@property (nonatomic, strong) NSMutableArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;
@end

#define VIEW_FOR_ZOOM_TAG (1)

@implementation AllSeasonGallery

@synthesize data;

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;

@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize imageView3 = _imageView3;
@synthesize imageView4 = _imageView4;
@synthesize imageView5 = _imageView5;


@synthesize index;






#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *viewsDictionary;
    
    UIBarButtonItem * newBackButton = [[UIBarButtonItem alloc] initWithTitle:(@"Back") style:UIBarButtonItemStyleBordered target:self action:@selector(Back:)];
    [newBackButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = newBackButton;
  
    if([data.gallery count] == 1){
        
        self.pageImages = [NSMutableArray arrayWithObjects:
                           _imageView1,
                           nil];
        
    }else if([data.gallery count] == 2){
        
        self.pageImages = [NSMutableArray arrayWithObjects:
                           _imageView1,
                           _imageView2,
                           nil];
        
    }else if([data.gallery count] == 3){
        
        self.pageImages = [NSMutableArray arrayWithObjects:
                           _imageView1,
                           _imageView2,
                           _imageView3,
                           nil];
        
    }else if([data.gallery count] == 4){
        
        self.pageImages = [NSMutableArray arrayWithObjects:
                           _imageView1,
                           _imageView2,
                           _imageView3,
                           _imageView4,
                           nil];
    }else if([data.gallery count] == 5){
        
        self.pageImages = [NSMutableArray arrayWithObjects:
                           _imageView1,
                           _imageView2,
                           _imageView3,
                           _imageView4,
                           _imageView5,
                           nil];
        
        
    }
    
    _containerView = [[UIView alloc]initWithFrame:_scrollView.frame];
    [_scrollView addSubview:_containerView];
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    
    
   // CGRect innerScrollFrame = _scrollView.frame;
   
    for (int i = 0; i < _pageImages.count; i++) {
     
        
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        
        _subview = [[UIImageView alloc] initWithFrame:frame];
        
       // _subview.tag = VIEW_FOR_ZOOM_TAG;
     
        _subview.contentMode = UIViewContentModeScaleAspectFit;
        
       
        
        
        [_subview setImage:[_pageImages objectAtIndex:i]];
     
       
     
        
        
        [_containerView addSubview:_subview];

    }
    
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _pageImages.count, self.scrollView.frame.size.height);
    pageControlBeingUsed = NO;
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = _pageImages.count;
    
 
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _containerView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    UIView * zoomView = [scrollView.delegate viewForZoomingInScrollView:scrollView];
    CGRect zvf = zoomView.frame;
    if(zvf.size.width<scrollView.bounds.size.width){
        zvf.origin.x = (scrollView.bounds.size.width - zvf.size.width)/2.0;
        
    }else{
        zvf.origin.x = 0.0;
    }
    if(zvf.size.height < scrollView.bounds.size.height){
        zvf.origin.y =(scrollView.bounds.size.height - zvf.size.height)/2.0;
    }else{
        zvf.origin.y = 0.0;
    }
    zoomView.frame = zvf;
}



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
        
        
        
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


-(void)Back:(UIBarButtonItem *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.scrollView = nil;
    self.pageControl = nil;
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end