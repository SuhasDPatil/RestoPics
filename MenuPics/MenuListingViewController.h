//
//  MenuListingViewController.h
//  MenuPics
//
//  Created by rac on 28/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenusTableViewCell.h"
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "MenuDetailsViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SCLAlertView.h"
@interface MenuListingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    dispatch_queue_t queue ;
    
    AppDelegate* appDelegate;
    
    NSMutableArray * MenuListArray;
    NSArray * searchMenuArray;
    
    MenusTableViewCell *tempCell;
    NSMutableArray * GetLikesArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchView;



@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (strong,nonatomic) NSMutableArray *filteredMenuArray;


//For storing of Parsed Response of Menu
@property(strong,nonatomic)NSString * DishID;
@property(strong,nonatomic)NSString * DishName;
@property(strong,nonatomic)NSString * DishPhoto;
@property(strong,nonatomic)NSString * DishPrice;
@property(strong,nonatomic)NSString * Dishdesc;
@property(strong,nonatomic)NSString * EnableDisLike;
@property(strong,nonatomic)NSString * EnableLike;
@property(strong,nonatomic)NSString * Task;
@property(nonatomic,strong)NSString * UserID;
@property(strong,nonatomic)NSString * dislike;
@property(strong,nonatomic)NSString * goodLike;
@property(strong,nonatomic)NSString * DishCals;



//For storing of Parsed Response of Get Restaurant Like
@property(strong,nonatomic)NSString * RDisLike;
@property(strong,nonatomic)NSNumber * RLike;



//For getting data from Rest list View Controller
@property(nonatomic,strong)NSString * FKRestaurantPin;
@property(nonatomic,strong)NSString * RestaurantName;
@property(nonatomic,strong)NSString * RestaurantAddress;
@property(nonatomic,strong)NSString * RestaurantCity;
@property(nonatomic,strong)NSString * RestaurantPhone1;

//For storing of Parsed Response of Save Restaurant Like and Dislike






//For storing which button is clicked
@property(strong,nonatomic)NSString *btnQRCode;





//Navigation Bar Button
@property(nonatomic,strong)UIButton *btnCall;
@property(nonatomic,strong)UIButton *btnAddress;
@property(nonatomic,strong)UIButton *btnFavourite;



//@property(strong,nonatomic)UIAlertView *alt;


@property(nonatomic)AFHTTPRequestOperationManager *operationManager;


@end
