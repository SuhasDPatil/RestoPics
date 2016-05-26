//
//  MenuDetailsViewController.h
//  MenuPics
//
//  Created by Suhas on 09/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "CustomIOSAlertView.h"
#import "LoginViewController.h"
#import "EXPhotoViewer.h"

#import <Social/Social.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface MenuDetailsViewController : UIViewController<UITextViewDelegate,CustomIOSAlertViewDelegate,UIAlertViewDelegate>
{
    
    dispatch_queue_t queue ;
   
    NSMutableArray * DetailListArray, *LikeDislikeListArray;
    
}


@property (strong, nonatomic) IBOutlet UIView *lblCommentBorder;


@property (strong, nonatomic) IBOutlet UILabel *lblCaloriesBorder;

@property (strong, nonatomic) IBOutlet UILabel *lblPriceBorder;




@property (strong, nonatomic) IBOutlet UILabel *lblPrice;

@property (strong, nonatomic) IBOutlet UILabel *lblDishName;

@property (strong, nonatomic) IBOutlet UILabel *lblDishNameBlack;

@property (strong, nonatomic) IBOutlet UILabel *lblDishCalories;

// vivek //
@property (strong, nonatomic) IBOutlet UIImageView *imagecalories;

@property (strong, nonatomic) IBOutlet UILabel *lblDishDetails;


@property (strong, nonatomic) IBOutlet UITextView *txtDishDetails;


@property (strong, nonatomic) IBOutlet UIImageView *imgDishImage;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (strong, nonatomic) IBOutlet UILabel *lblDishDescription;




@property (strong, nonatomic) IBOutlet UIImageView *imgLike;

@property (strong, nonatomic) IBOutlet UILabel *lblLikeCount;

@property (strong, nonatomic) IBOutlet UIImageView *imgDislike;

@property (strong, nonatomic) IBOutlet UILabel *lblDislikeCount;






@property (strong, nonatomic) IBOutlet UIButton *btnWriteComment;

@property (strong, nonatomic) IBOutlet UIButton *btnLike;

@property (strong, nonatomic) IBOutlet UIButton *btnDislike;

@property (strong, nonatomic) IBOutlet UILabel *lblBorderC;



@property (strong, nonatomic) IBOutlet UIButton *btnFacebookShare;

@property (strong, nonatomic) IBOutlet UIButton *btnTwitterPost;

@property (strong, nonatomic) IBOutlet FBSDKShareButton *btnFBShare;




@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;



@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;






- (IBAction)WriteCommentClicked:(id)sender;

- (IBAction)LikeClicked:(id)sender;

- (IBAction)DislikeClicked:(id)sender;

- (IBAction)backClicked:(id)sender;

- (IBAction)imgViewClicked:(id)sender;

- (IBAction)FacebookShreClicked:(id)sender;

- (IBAction)TwitterPostClicked:(id)sender;




//For getting field from Menu listing view

@property(strong,nonatomic)NSString * M_UserID;
@property(strong,nonatomic)NSString * M_DishID;
@property(strong,nonatomic)NSString * M_DishName;
@property(strong,nonatomic)NSString * M_DishPhoto;
@property(strong,nonatomic)NSString * M_DishPrice;
@property(strong,nonatomic)NSString * M_DishCals;
@property(strong,nonatomic)NSString * M_dislike;
@property(strong,nonatomic)NSString * M_goodLike;
@property(strong,nonatomic)NSString * M_Dishdesc;
@property(strong,nonatomic)NSString * M_RestaurantName;




//For storing of Parsed Response of Menu Details WS
@property(strong,nonatomic)NSString * DishCals;
@property(strong,nonatomic)NSString * DishID;
@property(strong,nonatomic)NSString * DishName;
@property(strong,nonatomic)NSString * DishPhoto;
@property(strong,nonatomic)NSString * DishPrice;
@property(strong,nonatomic)NSString * Dishdesc;
@property(strong,nonatomic)NSString * EnableDislike;
@property(strong,nonatomic)NSString * EnableLike;
@property(strong,nonatomic)NSString * Task;
@property(strong,nonatomic)NSString * UserID;
@property(strong,nonatomic)NSString * dislike;
@property(strong,nonatomic)NSString * goodLike;

@property(strong,nonatomic)NSString * FKRestaurantpin;
@property(strong,nonatomic)NSString * RestaurantName;
@property(strong,nonatomic)NSString * RestaurantPhone1;
@property(strong,nonatomic)NSString * RestaurantAddress;


//For storing of Parsed Response of Dish Like/Dislike WS
@property(strong,nonatomic)NSString * DishDisLike;
@property(strong,nonatomic)NSString * DishLike;





//For Comment- popup View
@property(nonatomic,strong)UIView *subview;

@property(nonatomic,strong)UIView * transperantView;

@property(nonatomic,strong)UIButton *sendButton;

@property(nonatomic,strong)UIButton *closeButton;

@property(nonatomic,strong)UITextView *txtview;




@property(nonatomic,strong)UIButton *btnCall;





//For Comment View

@property(nonatomic,strong)UITextView * txtCommentView;



//Alertview
@property(nonatomic,strong)UIAlertView *alt;



@end
