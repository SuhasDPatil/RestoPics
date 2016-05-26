//
//  FavouriteRestaurantViewController.h
//  MenuPics
//
//  Created by rac on 26/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "RestaurantViewCell.h"
#import "MenuListingViewController.h"
#import "DealsListViewController.h"

#import "AFAppAPIClient.h"
#import "Constant.h"


@interface FavouriteRestaurantViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    dispatch_queue_t queue ;
    
    NSMutableArray * RestaurantListArray;
    RestaurantViewCell *tempCell;

}






//For storing of Parsed Response
@property(strong,nonatomic)NSString * RestaurantAddress;
@property(strong,nonatomic)NSString * RestaurantCity;
@property(strong,nonatomic)NSString * RestaurantCountry;

@property(strong,nonatomic)NSString * RestaurantDesc;
@property(strong,nonatomic)NSString * RestaurantEmail;
@property(strong,nonatomic)NSString * RestaurantID;
@property(strong,nonatomic)NSString * RestaurantName;
@property(strong,nonatomic)NSString * RestaurantPhone1;
@property(strong,nonatomic)NSString * RestaurantPin;
@property(strong,nonatomic)NSString * RestaurantZipcode;
@property(strong,nonatomic)NSString * RestaurantPhoto;


@property(strong,nonatomic)NSString * DealCount;
@property(strong,nonatomic)NSString * RestaurantLikeCount;

@property(strong,nonatomic)NSString * Restaurant_Like;
@property(strong,nonatomic)NSNumber * Restaurant_Dislike;



@property(strong,nonatomic)UIAlertView *alt1;







@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;






@end
