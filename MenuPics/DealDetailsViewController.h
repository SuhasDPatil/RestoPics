//
//  DealDetailsViewController.h
//  MenuPics
//
//  Created by rac on 04/09/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "MenuListingViewController.h"
#import "LoginViewController.h"

#import "EXPhotoViewer.h"

#import <Social/Social.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface DealDetailsViewController : UIViewController
{
    dispatch_queue_t queue ;

}

@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantName;

@property (strong, nonatomic) IBOutlet UILabel *lblLikecount;

@property (strong, nonatomic) IBOutlet UILabel *lblDislikeCount;

@property (strong, nonatomic) IBOutlet UILabel *lblDealName;

@property (strong, nonatomic) IBOutlet UILabel *lblDate;

@property (strong, nonatomic) IBOutlet UILabel *lblTime;

@property (strong, nonatomic) IBOutlet UILabel *lblDealCondition;




@property (strong, nonatomic) IBOutlet UIImageView *imgDealPhoto;

@property (strong, nonatomic) IBOutlet UITextView *txtDealCondition;


@property (strong, nonatomic) IBOutlet UIButton *btnCall;

@property (strong, nonatomic) IBOutlet UIButton *btnAddress;

@property (strong, nonatomic) IBOutlet UIButton *btnMenus;

@property (strong, nonatomic) IBOutlet UIButton *btnImgZoom;

@property (strong, nonatomic) IBOutlet UIButton *btnComment;

@property (strong, nonatomic) IBOutlet UIButton *btnLIke;

@property (strong, nonatomic) IBOutlet UIButton *btnDislike;


@property (strong, nonatomic) IBOutlet UIButton *btnTwitterPost;

@property (strong, nonatomic) IBOutlet UIButton *btnFacebookShare;







@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;



@property(nonatomic)AFHTTPRequestOperationManager *operationManager;


//Get Data from DealListViewController

@property(strong,nonatomic)NSString * DealID;
@property(strong,nonatomic)NSString * dealName;
@property(strong,nonatomic)NSString * dealCondition;
@property(strong,nonatomic)NSString * DealPhoto;
@property(strong,nonatomic)NSString * StartDate;
@property(strong,nonatomic)NSString * EndDate;
@property(strong,nonatomic)NSString * StartTime;
@property(strong,nonatomic)NSString * endTime;

@property(strong,nonatomic)NSString * RestaurantName;
@property(strong,nonatomic)NSString * RestaurantAddress;
@property(strong,nonatomic)NSString * RestaurantPhone1;
@property(strong,nonatomic)NSString * RestaurantCity;
@property(strong,nonatomic)NSString * RestaurantCountry;
@property(strong,nonatomic)NSString * RestaurantPin;




- (IBAction)backClicked:(id)sender;

- (IBAction)callClicked:(id)sender;

- (IBAction)addressClicked:(id)sender;

- (IBAction)menuClicked:(id)sender;

- (IBAction)zoomClicked:(id)sender;

- (IBAction)commentClicked:(id)sender;

- (IBAction)likeClicked:(id)sender;

- (IBAction)dislikeClicked:(id)sender;



- (IBAction)twitterPostClicked:(id)sender;

- (IBAction)facebookShareClicked:(id)sender;




@end
