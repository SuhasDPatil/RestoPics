//
//  SearchViewController.m
//  MenuPics
//
//  Created by rac on 26/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    
    

    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER)
    {
        NSUInteger code = [CLLocationManager authorizationStatus];
        
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];

    self.navigationController.navigationBarHidden=YES;
    
    
    [[self.btnFindRest layer] setBorderWidth:1.0f];
    [[self.btnFindRest layer] setBorderColor:[UIColor clearColor].CGColor];
    [[self.btnFindRest layer]setCornerRadius:3.5f];
    
    [[self.lblBorder layer] setBorderWidth:5.0f];
    [[self.lblBorder layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.lblBorder layer]setCornerRadius:4.5f];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.navigationController.navigationBarHidden=YES;

}

-(void)viewWillAppear:(BOOL)animated
{    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    
    self.navigationController.navigationBarHidden=YES;
    self.txtSearch.text=nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)GPSClicked:(id)sender
{
    [self.txtSearch resignFirstResponder];
    
    RestaurantListViewController * rlvc=[[RestaurantListViewController alloc]init];
    
    rlvc.S_Lat=self.latit;
    rlvc.S_Long=self.longit;
    rlvc.btnGPS=@"GPS";
    
    
    [self.navigationController pushViewController:rlvc animated:YES];
    
}

- (IBAction)findRestClicked:(id)sender
{
    [self.txtSearch resignFirstResponder];
    
    self.searchText=self.txtSearch.text;
    NSLog(@"Search Text==%@",self.searchText);
    
    RestaurantListViewController * rlvc=[[RestaurantListViewController alloc]init];
    rlvc.btnFind=@"Find";
    NSLog(@"%@ Button Clicked",rlvc.btnFind);
    
    rlvc.S_text=self.searchText;
    NSLog(@"%@",rlvc.S_text);
    self.tabBarController.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:rlvc animated:YES];
}


#pragma mark - CLLocationManager
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    UIColor *color = [UIColor colorWithRed:255.0/255.0 green:161.0/255.0 blue:36.0/255.0 alpha:1.0];
    
    alert = [[SCLAlertView alloc] init];

    [alert showCustom:self image:[UIImage imageNamed:@"address_white"] color:color title:@"MenuPics" subTitle:@"Failed to Get Your Location " closeButtonTitle:@"OK" duration:0.0f];

//    [alert hideView];

    self.longit=[NSString stringWithFormat:@"0.000000"];
    self.latit=[NSString stringWithFormat:@"0.000000"];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@ ",newLocation);
    CLLocation * currentlocation=newLocation;
    
    if (currentlocation != nil)
    {
        
        self.longit=[NSString stringWithFormat:@"%.6f",currentlocation.coordinate.longitude];
        self.latit=[NSString stringWithFormat:@"%.6f",currentlocation.coordinate.latitude];
    }
    NSLog(@"Longitude= %+.6f  and Latitude= %+.6f",currentlocation.coordinate.longitude,currentlocation.coordinate.latitude);

    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_latit forKey:@"Lat"];
    [defaults setObject:_longit forKey:@"Long"];
    
    NSLog(@"NSDefaults: %@",defaults);
    
    NSLog(@"Lat Long ");
}



#pragma mark - TextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //  [self setKeyboard];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.searchText=self.txtSearch.text;
    NSLog(@"Search Text==%@",self.searchText);
    
    RestaurantListViewController * rlvc=[[RestaurantListViewController alloc]init];
    rlvc.btnFind=@"Find";
    NSLog(@"%@ Button Clicked",rlvc.btnFind);
    rlvc.S_text=self.searchText;
    NSLog(@"%@",rlvc.S_text);
    
    self.tabBarController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:rlvc animated:YES];
    return YES;
}

#pragma mark User Defined Methods

-(void)doneButtonClicked:(id)sender
{
    [_txtSearch resignFirstResponder];
}

-(void)dismissKeyboard
{
    [_txtSearch resignFirstResponder];
    UIColor *color = [UIColor lightGrayColor];
    
    _txtSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search by name, dish or hashtag" attributes:@{NSForegroundColorAttributeName: color}];
}




@end
