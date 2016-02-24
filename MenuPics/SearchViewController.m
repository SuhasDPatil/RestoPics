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

    self.title=@"Search";
    self.navigationController.navigationBarHidden=YES;
    
    
    [[self.btnFindRest layer] setBorderWidth:1.0f];
    [[self.btnFindRest layer] setBorderColor:[UIColor clearColor].CGColor];
    [[self.btnFindRest layer]setCornerRadius:3.5f];
    
    [[self.lblBorder layer] setBorderWidth:5.0f];
    [[self.lblBorder layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.lblBorder layer]setCornerRadius:4.5f];

//    [[self.viewBorder layer] setBorderWidth:5.0f];
//    [[self.viewBorder layer] setBorderColor:[UIColor clearColor].CGColor];
//    [[self.viewBorder layer]setCornerRadius:3.5f];

//    _txtSearch.placeholder=@"Search by name, dish or hashtag";
//    _txtSearch.delegate=self;
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.navigationController.navigationBarHidden=YES;

    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    //    [[UIView appearance]setTintColor:[UIColor darkTextColor]];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_bg_green"]];

    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_bg_orange"]];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GPSClicked:(id)sender
{
    [self SlideDownScreen];
    [self.txtSearch resignFirstResponder];
//    [self getLatLong];
    
    RestaurantListViewController * rlvc=[[RestaurantListViewController alloc]init];
    
    rlvc.S_Lat=self.latit;
    rlvc.S_Long=self.longit;
    rlvc.btnGPS=@"GPS";
    
    NSLog(@"Rest Longitude: %@",rlvc.S_Long);
    NSLog(@"Rest Latitude: %@",rlvc.S_Lat);
    NSLog(@"%@ Button Clicked",rlvc.btnGPS);
    
    [self.navigationController pushViewController:rlvc animated:YES];
    
}

- (IBAction)findRestClicked:(id)sender
{
    
    [self SlideDownScreen];
    
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
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
//    
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    UIColor *color = [UIColor colorWithRed:255.0/255.0 green:161.0/255.0 blue:36.0/255.0 alpha:1.0];
    
    
    [alert showCustom:self image:[UIImage imageNamed:@"address_white"] color:color title:@"MenuPics" subTitle:@"Failed to Get Your Location " closeButtonTitle:@"OK" duration:0.0f];


    
    
    
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
    [self SlideupScreen:textField];
    //  [self setKeyboard];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self SlideDownScreen];
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

-(void)setKeyboard
{
    UIToolbar* keyboardToolBar = [[UIToolbar alloc] init];
    //   [keyboardToolBar setBackgroundImage:[UIImage imageNamed:@"SerchbarBackground.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    keyboardToolBar.barStyle = UIBarStyleBlack;
    keyboardToolBar.backgroundColor=[UIColor orangeColor];
    keyboardToolBar.translucent = YES;
    keyboardToolBar.alpha=0.6f;
    // for ios 6
    keyboardToolBar.tintColor = [UIColor whiteColor];
    // for ios 7
    //keyboardToolBar.tintColor = [UIColor whiteColor];
    [keyboardToolBar sizeToFit];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneButtonClicked:)];
    [keyboardToolBar setItems:[NSArray arrayWithObjects:doneButton,flexibleSpaceLeft, nil]];
    _txtSearch.inputAccessoryView=keyboardToolBar;
}

-(void)doneButtonClicked:(id)sender
{
    [_txtSearch resignFirstResponder];
    [self SlideDownScreen];
    // for ios 6
    
    // for ios
    // CGPoint scrollPoint = CGPointMake(0, self.view.frame.origin.y-65);
    // [scrollView setContentOffset:scrollPoint animated:YES];
}

-(void)dismissKeyboard
{
    [_txtSearch resignFirstResponder];
    UIColor *color = [UIColor lightGrayColor];
    
    _txtSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search by name, dish or hashtag" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self SlideDownScreen];
}
//
//-(void)getLatLong
//{
//    loctionManager.delegate = self;
//    loctionManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [loctionManager startUpdatingLocation];
//    CLLocation * location=[loctionManager location];
//    CLLocationCoordinate2D coordinate=[location coordinate];
//    
//    //get latand long and assign to nsstring longit and latitu
//    self.longit=[NSString stringWithFormat:@"%f",coordinate.longitude];
//    self.latit=[NSString stringWithFormat:@"%f",coordinate.latitude];
//    NSLog(@"%@%@",_longit,_latit);
//    [loctionManager stopUpdatingLocation];
//}

-(void)SlideupScreen:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if ([[UIScreen mainScreen] bounds].size.height ==480)
    {
        if ([_txtSearch isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -45,320, self.view.frame.size.height)];
        }
    }
    else
    {
        if ([_txtSearch isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -50,320, self.view.frame.size.height)];
        }
    }
    [UIView commitAnimations];
}

-(void)SlideDownScreen
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [UIView commitAnimations];
}




@end
