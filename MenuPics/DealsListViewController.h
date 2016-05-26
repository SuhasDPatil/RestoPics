//
//  DealsListViewController.h
//  MenuPics
//
//  Created by rac on 26/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "DealDetailsViewController.h"
#import "DealsViewCell.h"
#import "SCLAlertView.h"

@interface DealsListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    dispatch_queue_t queue ;
    
    NSMutableArray * DealListArray;
    DealsViewCell *tempCell;
    
}




@property(strong,nonatomic)NSString * S_Lat;
@property(strong,nonatomic)NSString * S_Long;



@property(nonatomic,strong)NSString * restaurantsID;
@property(nonatomic,strong)NSString * btnDeal;



@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;





//For storing of Parsed Response
//********    Restaurant Info
@property(strong,nonatomic)NSString * RestaurantID;
@property(strong,nonatomic)NSString * RestaurantName;
@property(strong,nonatomic)NSString * RestaurantAddress;
@property(strong,nonatomic)NSString * RestaurantPhone1;
@property(strong,nonatomic)NSString * RestaurantPhoto;
@property(strong,nonatomic)NSString * RestaurantCity;
@property(strong,nonatomic)NSString * RestaurantCountry;
@property(strong,nonatomic)NSString * RestaurantDesc;
@property(strong,nonatomic)NSString * RestaurantEmail;
@property(strong,nonatomic)NSString * RestaurantHastag;
@property(strong,nonatomic)NSString * RestaurantManagerEmail;
@property(strong,nonatomic)NSString * RestaurantManagerName;
@property(strong,nonatomic)NSString * RestaurantManagerPhone;
@property(strong,nonatomic)NSString * RestaurantPhone2;
@property(strong,nonatomic)NSString * RestaurantPin;
@property(strong,nonatomic)NSString * RestaurantState;
@property(strong,nonatomic)NSString * RestaurantZipcode;
@property(strong,nonatomic)NSString * RestaurantActivateViaEmail;
//********     Deal info
@property(strong,nonatomic)NSString * DealID;
@property(strong,nonatomic)NSString * dealName;
@property(strong,nonatomic)NSString * dealCondition;
@property(strong,nonatomic)NSString * DealPhoto;
@property(strong,nonatomic)NSString * StartDate;
@property(strong,nonatomic)NSString * EndDate;
@property(strong,nonatomic)NSString * StartTime;
@property(strong,nonatomic)NSString * endTime;





@property(strong,nonatomic)UIAlertView *alt1;




@end
