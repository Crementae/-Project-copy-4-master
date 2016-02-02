//
//  MarkerView.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 4/22/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "MarkerView.h"
#import "PlaceData.h"
#import "ARGeoCoordinate.h"
#import "UIImageView+WebCache.h"
#import "DataUtil.h"

@interface MarkerView()
@end

@implementation MarkerView

NSArray *data;
NSMutableArray *imgData;
const float boxWidth = 261.0f;
const float boxHeight = 95.0f;
const float boxGap = 10.0f;
const float boxAlpha = 0.8f;
const float labelHeight = 20.0f;

@synthesize coordinateInfo;
@synthesize delegate;
@synthesize lblDistance;
@synthesize lblTitle;




int running = 1;

- (id)initForCoordinate:(ARGeoCoordinate *)coordinate
            withDelgate:(id<ARMarkerDelegate>) aDelegate
               withData:(PlaceData *)data
                  withX:(float)x
                  withY:(float)y{
    
    [self setCoordinateInfo:coordinate];
    [self setDelegate:aDelegate];
    
    CGRect theFrame = CGRectMake(0 + x, 0 + y, boxWidth, boxHeight);
    
    if ((self = [super initWithFrame:theFrame])) {
        
        [self setUserInteractionEnabled:YES]; // Allow for touches
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        backgroundImageView.image = [UIImage imageNamed:@"MapDialog"];
        [backgroundImageView setFrame:theFrame];
        /*
        NSURL *urlToPicture1 = [NSURL URLWithString:data.thumbnail];
        NSData * thumbnailPath = [NSData dataWithContentsOfURL:urlToPicture1];
        UIImage *image1 = [UIImage imageWithData:thumbnailPath];
        UIImageView *thumbnailImageView = [[UIImageView alloc] initWithImage:image1];
        NSLog(@"thumb %@",data.thumbnail);
        
        
        
        UIImageView * thumbnailImageView = [[UIImageView alloc] init];
        
        SDWebImageManager * manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:data.thumbnail] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        }completed:^(UIImage * image, NSError * error, SDImageCacheType cachedType, BOOL finished,NSURL *imageURL){
            if(image == finished){
                [thumbnailImageView setImage:image];
            }else{
                [thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:data.thumbnail]  placeholderImage:[UIImage imageNamed:@"1.png"]  completed:^(UIImage * img, NSError *error, SDImageCacheType cachedType, NSURL * imageURL){
                    
                    if(!marker.snippet||!cachedType){
                        [marker setSnippet:@""];
                        if(mapView.selectedMarker == marker){
                            [mapView setSelectedMarker:marker];
                     
                        }
                        
                    }
                    
                }];
            }
        }];
        */
        
        
        UIImageView *thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
         [thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[data.thumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"noImg.png"]];
        
        //thumbnailImageView.image = [UIImage imageNamed:@"1.png"];
       
        
        [thumbnailImageView setFrame:CGRectMake(15 + x, 15 + y, 55, 55)];
        
        UILabel *titleLabel	= [[UILabel alloc] initWithFrame:CGRectMake(0 + x, 0 + y, boxWidth, 20.0)];
        
        [titleLabel setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
        [titleLabel setTextColor:		[UIColor blackColor]];
        [titleLabel setTextAlignment:	NSTextAlignmentLeft];
        [titleLabel setText:			data.name];
        NSLog(@"name %@",data.name);
        
       // //NSLog(@"name %@",data.name);
        
        //titleLabel.font = [titleLabel.font fontWithSize:10];
        titleLabel.font = [UIFont fontWithName:@"browa_0" size:22];
        [titleLabel sizeToFit];
        
        //[titleLabel setFrame: CGRectMake(BOX_WIDTH / 2.0 - [titleLabel bounds].size.width / 2.0 - 4.0, 0,
        //                                 [titleLabel bounds].size.width + 8.0, [titleLabel bounds].size.height + 8.0)];
        [titleLabel setFrame: CGRectMake(
                                         thumbnailImageView.frame.origin.x + thumbnailImageView.frame.size.width +
                                         5.0 + x,
                                         10 + y,
                                         130,
                                         [titleLabel bounds].size.height + 8.0)];
        
        //UILabel *distLbl = [[UILabel alloc] initWithFrame:CGRectMake(0 + x, 0 + y, boxWidth, labelHeight)];
        self.lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(0 + x, 0 + y, boxWidth, labelHeight)];
        
        
        //[distLbl setBackgroundColor: [UIColor colorWithWhite:.3 alpha:BOX_ALPHA]];
        [self.lblDistance setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
        [self.lblDistance setTextColor:		[UIColor blackColor]];
        [self.lblDistance setTextAlignment:	NSTextAlignmentLeft];
        
        //NSString *runningStr = [[NSString alloc] initWithFormat:@"%d",running++];
        
        self.lblDistance.text = @"Loading..";
        //[distLbl setText:			[NSString stringWithFormat:@"%f", [coordinate distanceFromOrigin]]];
        self.lblDistance.font = [UIFont fontWithName:@"browa_0" size:18];
        [self.lblDistance sizeToFit];
        //distLbl.font = [distLbl.font fontWithSize:10];
        
        [self.lblDistance setFrame: CGRectMake(titleLabel.frame.origin.x,
                                               50 + y,
                                               [titleLabel bounds].size.width + 8.0,
                                               [self.lblDistance bounds].size.height + 8.0)];
        
        
        UILabel *moreLabel	= [[UILabel alloc] initWithFrame:CGRectMake(0 + x, 0 + y, boxWidth, 20.0)];
        
        [moreLabel setBackgroundColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
        [moreLabel setTextColor:		[UIColor blackColor]];
        [moreLabel setTextAlignment:	NSTextAlignmentLeft];
        [moreLabel setText:			[NSString stringWithFormat:data.scientific_name]];
        NSLog(@"Sciname %@",data.scientific_name);
        moreLabel.font = [UIFont fontWithName:@"browa_0" size:18];
        //moreLabel.font = [moreLabel.font fontWithSize:10];
        [moreLabel sizeToFit];
        
        [moreLabel setFrame: CGRectMake(
                                        thumbnailImageView.frame.origin.x + thumbnailImageView.frame.size.width +
                                        5.0 + x,
                                        30 + y,
                                        [self.lblDistance bounds].size.width + 8.0,
                                        [moreLabel bounds].size.height + 8.0)];
        
        [self addSubview:backgroundImageView];
        [self addSubview:thumbnailImageView];
        [self addSubview:titleLabel];
        [self addSubview:self.lblDistance];
        [self addSubview:moreLabel];
        
        //[self setLblDistance:distLbl];
        [self setLblTitle:titleLabel];
        
        //[self addSubview:pointView];
        [self setBackgroundColor:[UIColor clearColor]];
    }
 
    
    return self;
}

-(void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    /*NSString *runningStr = [[NSString alloc] initWithFormat:@"%d",running++];
     
     [[self lblDistance] setText:runningStr];*/
    
    //[[self lblDistance] setText:[NSString stringWithFormat:@"%f m", [[self coordinateInfo] distanceFromOrigin]]];
    
    //if([lblTitle.text isEqual: @"มะกอก"]){
    ////NSLog(@"DrawRect: %f m", [[self coordinateInfo] radialDistance]);
    //}
}

-(void) forceRedraw{
    //NSString *runningStr = [[NSString alloc] initWithFormat:@"%d",running++];
    
    //[lblDistance setText:runningStr];
    //[self setNeedsDisplay:YES];
    [[self lblDistance] setText:[NSString stringWithFormat:@"%.2f m", [[self coordinateInfo] distanceFromOrigin]]];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ////NSLog(@"%@ was touched!",[[self coordinateInfo] title]);
    [delegate didTapMarker:[self coordinateInfo]];
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    CGRect theFrame = CGRectMake(0, 0, boxWidth, boxHeight);
    
    if(CGRectContainsPoint(theFrame, point))
        return YES; // touched the view;
    
    return NO;
}


- (void)dealloc
{
    
}


@end
