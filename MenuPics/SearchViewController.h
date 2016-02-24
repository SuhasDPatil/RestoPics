//
//  SearchViewController.h
//  MenuPics
//
//  Created by rac on 26/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RestaurantListViewController.h"
#import "Constant.h"
#import "DealsListViewController.h"
#import "SCLAlertView.h"

@interface SearchViewController : UIViewController<CLLocationManagerDelegate,UITextFieldDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;


@property (strong, nonatomic) IBOutlet UIButton *btnFindRest;

@property (strong, nonatomic) IBOutlet UIView *viewBorder;

@property (strong, nonatomic) IBOutlet UILabel *lblBorder;


@property (strong, nonatomic) IBOutlet UITextField *txtSearch;

@property (strong, nonatomic) IBOutlet UIButton *btnGPS;



- (IBAction)GPSClicked:(id)sender;

- (IBAction)findRestClicked:(id)sender;





//Store User Lat Long
@property(nonatomic,strong)NSString *latit;
@property(nonatomic,strong)NSString *longit;



//for Search Restaurant text
@property(nonatomic,strong)NSString * searchText;






@end
