//
//  DealDetailsViewController.m
//  MenuPics
//
//  Created by rac on 04/09/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import "DealDetailsViewController.h"

@interface DealDetailsViewController ()

@end

@implementation DealDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavBar];
    
    if ([[UIScreen mainScreen] bounds].size.height ==480)
    {
        [_scrollView setContentSize:CGSizeMake(320, 340)];
    }
    else
    {
        [_scrollView setContentSize:CGSizeMake(320, 255)];
    }

    self.lblRestaurantName.text=_RestaurantName;
    self.lblDealName.text=_dealName;
    self.txtDealCondition.text=_dealCondition;
    
    
    self.lblDealCondition.text=_dealCondition;
    
    self.lblDate.text=[NSString stringWithFormat:@"%@ to %@",_StartDate,_EndDate];
    self.lblTime.text=[NSString stringWithFormat:@"%@ to %@",_StartTime,_endTime];
    
//    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
//    
//    dispatch_async(queue, ^(){
//        
//        [_indicatorView startAnimating];
//        
//        NSString * imgURL = self.DealPhoto;
//        NSString *replacedStr = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];
//        
//        
//        NSString * reps=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
//        
//        NSString * combined=[reps stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        
//        NSURL * url = [NSURL URLWithString:combined];
//        NSData * imgData = [NSData dataWithContentsOfURL:url];
//        UIImage * image = [UIImage imageWithData:imgData];
//        
//        dispatch_async( dispatch_get_main_queue() , ^(){
//            
//            self.imgDealPhoto.image=image;
//            
//            [_indicatorView stopAnimating];
//        });
//    });
    
    NSString * imgURL = self.DealPhoto;
    NSString *replacedStr = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];

    NSString * reps=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];

    NSString * combined=[reps stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [self.operationManager GET: combined
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           self.imgDealPhoto.image = responseObject;
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           NSLog(@"Failed with error %@.", error);
                       }];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(AFHTTPRequestOperationManager *)operationManager
{
    if (!_operationManager)
    {
        _operationManager = [[AFHTTPRequestOperationManager alloc] init];
        _operationManager.responseSerializer = [AFImageResponseSerializer serializer];
    };
    
    return _operationManager;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden=NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;

}

-(void)viewWillAppear:(BOOL)animated
{
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];

    
    self.navigationController.navigationBarHidden=YES;

    
    //Facebook Sharing Button
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    NSString *urlString=[NSString stringWithFormat:@"http://www.trymenupics.com/"];
    
    
    
    content.contentURL = [NSURL URLWithString:urlString];
    
    
    
    content.contentTitle=[NSString stringWithFormat:@"%@ \n : %@",_RestaurantName,_dealName];
    
    content.contentDescription=[NSString stringWithFormat:@"\n %@",_dealCondition];
    
    
    NSString * imgURL = self.DealPhoto;
    
    NSString *combined = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];
    
    
    NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    
    
    NSString * rep=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
    
    
    
    content.imageURL=[NSURL URLWithString:rep];
    FBSDKShareButton *Sharebutton;
    
    Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(50, 181, 80, 30)];
    
//     if ([[UIScreen mainScreen] bounds].size.height ==480)
//     {
//         Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(50, 283, 80, 30)];
//     }
//     else
//     {
//         Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(40, 283, 80, 30)];
//     }
    
    Sharebutton.shareContent = content;
    
    [Sharebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [Sharebutton setBackgroundColor:[UIColor clearColor]];
    
    [Sharebutton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    
    [Sharebutton setTintColor:[UIColor clearColor]];
    
    [self.scrollView addSubview:Sharebutton];
    

    
}


- (void)didReceiveMemoryWarning {
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



#pragma mark User Defined
-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    //    [self.navigationController.navigationBar
    //     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial Rounded MT Bold" size:14],NSFontAttributeName, nil]];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 16, 10);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
};

- (IBAction)callClicked:(id)sender
{
    NSString *phNo = self.RestaurantPhone1;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [[UIApplication sharedApplication] openURL:phoneUrl];

    }
    else
    {
        UIAlertView * calert = [[UIAlertView alloc]initWithTitle:APP_NAME message:@"\nCall facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [calert show];
    }

    
}

- (IBAction)addressClicked:(id)sender
{
    
    UIAlertView * alt=[[UIAlertView alloc]initWithTitle:self.RestaurantName message:[NSString stringWithFormat:@"\n%@,\n%@.",self.RestaurantAddress,self.RestaurantCity] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alt show];
    
}

- (IBAction)menuClicked:(id)sender
{
    
    MenuListingViewController * mlvc=[[MenuListingViewController alloc]init];
    
    mlvc.FKRestaurantPin=_RestaurantPin;
    mlvc.RestaurantName=_RestaurantName;
    mlvc.RestaurantAddress=_RestaurantAddress;
    mlvc.RestaurantCity=_RestaurantCity;
    mlvc.RestaurantPhone1=_RestaurantPhone1;
    
    [self.navigationController pushViewController:mlvc animated:YES];
    
}

- (IBAction)zoomClicked:(id)sender
{
    [EXPhotoViewer showImageFrom:_imgDealPhoto];

}

- (IBAction)commentClicked:(id)sender
{
    
}

- (IBAction)likeClicked:(id)sender
{
    

    
}



- (IBAction)dislikeClicked:(id)sender
{
    
}









- (IBAction)twitterPostClicked:(id)sender
{
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ : %@",self.RestaurantName,self.dealName]];
        
        [tweetSheet addURL:[NSURL URLWithString:@"http://www.trymenupics.com/"]];
        
        NSString * imgURL = self.DealPhoto;
        NSString *replacedStr = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];
        
        
        NSString * reps=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
        
        NSString * combined=[reps stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * url = [NSURL URLWithString:combined];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        
        
        [tweetSheet addImage:[UIImage imageWithData:imgData]];
        
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        
        
        SLComposeViewController *TWITTER = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        
        [self presentViewController:TWITTER animated:YES completion:nil];
        
        
    }
    
    
}

- (IBAction)facebookShareClicked:(id)sender
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller addURL:[NSURL URLWithString:@"http://www.trymenupics.com/"]];

        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook" message:@"Facebook integration is not available.  Make sure you have setup your Facebook account on your device." delegate:self cancelButtonTitle:@"Settings" otherButtonTitles:@"OK", nil];
        [alert show];
        alert.tag=101;
    }
    
}
@end
