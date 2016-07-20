//
//  MenuDetailsViewController.m
//  MenuPics
//
//  Created by Suhas on 09/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "MenuDetailsViewController.h"

@interface MenuDetailsViewController ()

@end

@implementation MenuDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self MenuDetailsWebService];


    if ([[UIScreen mainScreen] bounds].size.height ==480)
    {
        [_scrollView setContentSize:CGSizeMake(320, 420)];
    }
    else
    {
        [_scrollView setContentSize:CGSizeMake(320, 335)];
    }
    
    self.navigationController.navigationBarHidden=YES;

    self.title=self.M_RestaurantName;
    
    [[self.imgDishImage layer]setBorderWidth:1.2f];
    [[self.imgDishImage layer]setBorderColor:[UIColor clearColor].CGColor];
    [[self.imgDishImage layer]setCornerRadius:3.5f];
    
    [[self.btnWriteComment layer]setBorderWidth:1.2f];
    [[self.btnWriteComment layer]setBorderColor:[UIColor clearColor].CGColor];
    [[self.btnWriteComment layer]setCornerRadius:3.f];
    
    
    
    [[self.lblCaloriesBorder layer]setBorderWidth:17.2f];
    [[self.lblCaloriesBorder layer]setBorderColor:[UIColor whiteColor].CGColor];
    [[self.lblCaloriesBorder layer]setCornerRadius:17.2f];
    
    [[self.lblPriceBorder layer]setBorderWidth:3.2f];
    [[self.lblPriceBorder layer]setBorderColor:[UIColor clearColor].CGColor];
    [[self.lblPriceBorder layer]setCornerRadius:3.f];
    
    [[self.lblCommentBorder layer]setBorderWidth:3.2f];
    [[self.lblCommentBorder layer]setBorderColor:[UIColor clearColor].CGColor];
    [[self.lblCommentBorder layer]setCornerRadius:3.f];
    
    
    
    
    self.lblDishName.text=self.M_DishName;
    self.lblDishNameBlack.text=self.M_DishName;
    
    NSString * strPrice=self.M_DishPrice;
    
    NSString * strP=@"PRICE $";
    self.lblPrice.text=[NSString stringWithFormat:@"%@%@",strP,strPrice];
    NSString *strCalories=self.M_DishCals;
    NSString *strC=@" Calories";
    
    
    if ([strCalories isEqualToString:@"0"])
    {
        
        self.lblDishCalories.hidden=YES;
        self.lblCaloriesBorder.hidden=YES;
        self.imagecalories.hidden=YES;
    
    }
    else
    {
        self.lblDishCalories.text=[NSString stringWithFormat:@"%@%@",strCalories,strC];
        
    }
    
    _btnLike.hidden=YES;
    _btnDislike.hidden=YES;
    
    
    self.lblDishDetails.text=self.M_Dishdesc;
    
    self.txtDishDetails.text=self.M_Dishdesc;
    
    self.lblDishDescription.text=self.M_Dishdesc;
    
    
    NSString * imgURL = self.M_DishPhoto;
    
    NSString *replacedStr = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];
    
    NSString * reps=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
    
    NSString * combined=[reps stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    
    [self.operationManager GET: combined
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           self.imgDishImage.image = responseObject;
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           NSLog(@"Failed with error %@.", error);
                       }];

    
    
    
    [self setKeyboard];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

  
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

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{

    [self FacebookShreClicked:recognizer];
    
    //Do stuff here...
}


-(void)dismissKeyboard
{
    [_txtCommentView resignFirstResponder];
    [_txtview resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];

}


-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
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


#pragma mark ButtonClick methods

- (IBAction)WriteCommentClicked:(id)sender
{
    
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * str=[defaults objectForKey:@"UserID"];
    
    if ([str isEqual:@"0"])
    {
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        
        LoginViewController * log=[[LoginViewController alloc]init];
        log.FromProfileView=@"MenuList";
        
        [self.navigationController pushViewController:log animated:YES];

    }
    else
    {
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        // Add some custom content to the alert view
        [alertView setContainerView:[self createDemoView]];
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Comment",  nil]];
        [alertView setDelegate:self];
        
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        [alertView setUseMotionEffects:true];
        alertView.tag=100;
        [alertView show];
    }
}

- (IBAction)LikeClicked:(id)sender
{
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * str=[defaults objectForKey:@"UserID"];
    
    if ([str isEqual:@"0"])
    {
        
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        
        LoginViewController * log=[[LoginViewController alloc]init];
        log.FromProfileView=@"MenuList";

        [self.navigationController pushViewController:log animated:YES];

    }
    else
    {
        [self LikeWebService];
    }
}

- (IBAction)DislikeClicked:(id)sender
{
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * str=[defaults objectForKey:@"UserID"];
    
    if ([str isEqual:@"0"])
    {
        
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        
        LoginViewController * log=[[LoginViewController alloc]init];
        log.FromProfileView=@"MenuList";

        [self.navigationController pushViewController:log animated:YES];

    }
    else
    {
        [self DislikeWebService];
    }

}

- (IBAction)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)imgViewClicked:(id)sender
{
    
    [EXPhotoViewer showImageFrom:_imgDishImage];
    
    
}

- (IBAction)FacebookShreClicked:(id)sender
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                        message:@"Facebook integration is not available.  Make sure you have setup your Facebook account on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        alert.tag=101;
    }

    
}

- (IBAction)TwitterPostClicked:(id)sender
{
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ : %@",self.RestaurantName,self.M_DishName]];
        
        [tweetSheet addURL:[NSURL URLWithString:@"http://www.trymenupics.com/"]];
        
        NSString * imgURL = self.M_DishPhoto;
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
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111)
    {
        if (buttonIndex==1)
        {
            LoginViewController * log=[[LoginViewController alloc]init];
            log.FromProfileView=@"MenuList";

            [self.navigationController pushViewController:log animated:YES];
        }
    }
    else if (alertView.tag==222)
    {
        if (buttonIndex==1)
        {
            LoginViewController * log=[[LoginViewController alloc]init];
            log.FromProfileView=@"MenuList";

            [self.navigationController pushViewController:log animated:YES];
        }
    }

}

#pragma mark CustomIOSAlertViewDelegate
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        [alertView close];
    }
    else
    {
        
        [self CommentWebService];
        [alertView close];
    }
}


#pragma mark UITextViewDelegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _txtCommentView.text=@"";
    return YES;
    
    _txtCommentView.textColor=[UIColor darkTextColor];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}


#pragma mark User Defined Methods

-(void)setKeyboard
{
    
    UIToolbar* keyboardToolBar = [[UIToolbar alloc] init];
    //   [keyboardToolBar setBackgroundImage:[UIImage imageNamed:@"SerchbarBackground.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    
    keyboardToolBar.barStyle = UIBarStyleBlack;
    keyboardToolBar.backgroundColor=[UIColor darkGrayColor];
    keyboardToolBar.translucent = YES;
    keyboardToolBar.alpha=0.8f;
    // for ios 6
    keyboardToolBar.tintColor = [UIColor whiteColor];
    // for ios 7
    //keyboardToolBar.tintColor = [UIColor whiteColor];
    
    [keyboardToolBar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneButtonClicked:)];
    [keyboardToolBar setItems:[NSArray arrayWithObjects:doneButton,flexibleSpaceLeft, nil]];
    
    _txtCommentView.inputAccessoryView=keyboardToolBar;
    _txtview.inputAccessoryView=keyboardToolBar;

    
}

-(void)doneButtonClicked:(id)sender
{
    [_txtCommentView resignFirstResponder];
    [_txtview resignFirstResponder];
}




- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
   
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 290, 30)];
    lbl.text=_DishName;
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:@"System Bold" size:15];
    lbl.textColor=[UIColor darkTextColor];
    [demoView addSubview:lbl];

    _txtCommentView=[[UITextView alloc]initWithFrame:CGRectMake(10, 38, 270, 155)];
    _txtCommentView.text=@"Share Your Thoughts...";
    _txtCommentView.textColor=[UIColor darkGrayColor];
    _txtCommentView.delegate=self;
    
    
    [[self.txtCommentView layer]setBorderWidth:1.2f];
    [[self.txtCommentView layer]setBorderColor:[UIColor clearColor].CGColor];
    [[self.txtCommentView layer]setCornerRadius:3.f];

    
    [demoView addSubview:_txtCommentView];
    
    return demoView;
}

-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor clearColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial Rounded MT Bold" size:14],NSFontAttributeName, nil]];

    //Back Button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 16, 10);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    //Address Button
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage = [UIImage imageNamed:@"Address1.png"]  ;
    [rightBtn setBackgroundImage:rightBtnImage forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 17, 14);
    UIBarButtonItem *Address = [[UIBarButtonItem alloc] initWithCustomView:rightBtn] ;
    
    //Call Button
    _btnCall= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage2 = [UIImage imageNamed:@"call1.png"]  ;
    [_btnCall setBackgroundImage:rightBtnImage2 forState:UIControlStateNormal];
    [_btnCall addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    _btnCall.frame = CGRectMake(0, 0, 19, 15);
    UIBarButtonItem *Call= [[UIBarButtonItem alloc] initWithCustomView:_btnCall] ;
    
    self.navigationItem.rightBarButtonItems=[[NSArray alloc]initWithObjects:Address, Call, nil];

}

-(void)callAction
{
  
    NSString *phNo = self.RestaurantPhone1;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        UIAlertView * calert = [[UIAlertView alloc]initWithTitle:APP_NAME message:@"\nCall facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        [calert show];
    }
}

-(void)addressAction
{
    UIAlertView *altA=[[UIAlertView alloc]initWithTitle:self.RestaurantName message:[NSString stringWithFormat:@"\n%@.",self.RestaurantAddress] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [altA show];
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Webservices


-(void)MenuDetailsWebService
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:self.M_DishID forKey:@"DishID"];
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * userID=[defaults objectForKey:@"UserID"];
    [dict setObject:userID forKey:@"UserID"];
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_DISH_DETAIL_DISH_ID
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.indicatorView startAnimating];
         _btnLike.hidden=NO;
         _btnDislike.hidden=NO;
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             // NSArray *list=[responseObject objectForKey:@"Data"];
             DetailListArray=[[NSMutableArray alloc]init];
             DetailListArray=[responseObject objectForKey:@"Data"];
             if(DetailListArray.count>0)
             {
                 int i;
                 for (i=0; i<DetailListArray.count; i++)
                 {
                     NSDictionary * d = [DetailListArray objectAtIndex:i];
                     
                     _DishCals=[d valueForKey:@"DishCals"];
                     _DishID=[d valueForKey:@"DishID"];
                     _DishName=[d valueForKey:@"DishName"];
                     _DishPhoto=[d valueForKey:@"DishPhoto"];
                     _DishPrice=[d valueForKey:@"DishPrice"];
                     _Dishdesc=[d valueForKey:@"Dishdesc"];
                     _EnableDislike=[d valueForKey:@"EnableDisLike"];
                     _EnableLike=[d valueForKey:@"EnableLike"];
                     _Task=[d valueForKey:@"Task"];
                     _UserID=[d valueForKey:@"UserID"];
                     _dislike=[d valueForKey:@"dislike"];
                     _goodLike=[d valueForKey:@"goodLike"];
                     _RestaurantName=[d valueForKey:@"RestaurantName"];
                     _RestaurantAddress=[d valueForKey:@"RestaurantAddress"];
                     _RestaurantPhone1=[d valueForKey:@"RestaurantPhone1"];
                     _FKRestaurantpin=[d valueForKey:@"FKRestaurantpin"];
                     
                     self.lblDishName.text=[d valueForKey:@"DishName"];
                     
                     self.lblLikeCount.text=[d valueForKey:@"goodLike"];
                     self.lblDislikeCount.text=[d valueForKey:@"dislike"];
                     
                     
                 
                     CGSize maximumLabelSize=CGSizeMake(296, FLT_MAX);
                     
                     CGSize expectedLabelSize=[_Dishdesc sizeWithFont:_lblDishDescription.font constrainedToSize:maximumLabelSize lineBreakMode:_lblDishDescription.lineBreakMode];
                     CGRect newframe=_lblDishDescription.frame;
                     newframe.size.height=expectedLabelSize.height;
                     _lblDishDescription.frame=newframe;
                     
                     
                     
                 }

                 
                 
                 //For check If Already Liked or Disliked a Dish ....
                 
                 if ([_EnableLike isEqualToString:@"1"]&&[_EnableDislike isEqualToString:@"0"])
                 {
                     _imgLike.image=[UIImage imageNamed:@"like_orange.png"];
                     _imgDislike.image=[UIImage imageNamed:@"dislike_gray.png"];
                     _lblLikeCount.textColor=[UIColor orangeColor];
                     _lblDislikeCount.textColor=[UIColor grayColor];
                 }
                 else if ([_EnableLike isEqualToString:@"0"]&&[_EnableDislike isEqualToString:@"1"])
                 {
                     _imgLike.image=[UIImage imageNamed:@"like_gray.png"];
                     _imgDislike.image=[UIImage imageNamed:@"dislike_orange.png"];
                     _lblLikeCount.textColor=[UIColor grayColor];
                     _lblDislikeCount.textColor=[UIColor orangeColor];

                 }
                 
                 
                 //Facebook Sharing Button
                 
                 FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
                 NSString *urlString=[NSString stringWithFormat:@"http://www.trymenupics.com/"];
                 content.contentURL = [NSURL URLWithString:urlString];
                 content.contentTitle=[NSString stringWithFormat:@"%@ \n : %@",_RestaurantName,_DishName];
                 content.contentDescription=[NSString stringWithFormat:@"\n %@",_Dishdesc];
                 NSString * imgURL = self.M_DishPhoto;
                 NSString *combined = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];
                 NSString * replacedStr=[combined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                 NSString * rep=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
                 content.imageURL=[NSURL URLWithString:rep];
                 FBSDKShareButton *Sharebutton;
                 Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(8, 242, 150, 30)];

//                 if ([[UIScreen mainScreen] bounds].size.height ==480)
//                 {
//                     Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(70, 285, 80, 30)];
//                 }
//                 else
//                 {
//                     Sharebutton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(40, 485, 100, 30)];
//                 }
                 
                 Sharebutton.shareContent = content;
                 
                 [Sharebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                 
                 [Sharebutton setBackgroundColor:[UIColor clearColor]];
                 
                 [Sharebutton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                 
                 [Sharebutton setTintColor:[UIColor clearColor]];
                 
                 [self.scrollView addSubview:Sharebutton];
                 

                 
             }
             else
             {
                 [self.navigationController popViewControllerAnimated:YES];
                 //      NSError *error;
             }
         }
         else
         {
             //  NSError *error;
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
         [self.indicatorView stopAnimating];
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [Utiles showAlert:self.RestaurantName Message:[error localizedDescription]];
         [self.navigationController popViewControllerAnimated:YES];
     }];
}



//Write Comment Web-Service

-(void)CommentWebService
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:_txtCommentView.text forKey:@"Comment"];
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * userID=[defaults objectForKey:@"UserID"];
    [dict setObject:userID forKey:@"UserID"];
    [dict setObject:self.DishID forKey:@"DishID"];
    [dict setObject:self.FKRestaurantpin forKey:@"FkresturantPin"];

    
    [[AFAppAPIClient WSsharedClient] POST:API_SAVE_DISH_COMMENT
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         [self.indicatorView startAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             
         }
         else
         {
             //  NSError *error;
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
         [self.indicatorView stopAnimating];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [Utiles showAlert:self.RestaurantName Message:[error localizedDescription]];
         [self.navigationController popViewControllerAnimated:YES];
     }];
}



//Like Dish Menu Web Service

-(void)LikeWebService
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:self.DishID forKey:@"DishID"];
    [dict setObject:@"1" forKey:@"Task"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [dict setObject:[defaults objectForKey:@"UserID"] forKey:@"UserID"];

    
    [[AFAppAPIClient WSsharedClient] POST:API_SAVE_DISH_LIKE_DISLIKE
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.indicatorView stopAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             LikeDislikeListArray=[[NSMutableArray alloc]init];
             LikeDislikeListArray=[responseObject objectForKey:@"Data"];
             if(LikeDislikeListArray.count>0)
             {
             
                 NSDictionary * d = [LikeDislikeListArray objectAtIndex:0];
                 
                 _M_goodLike=[d valueForKey:@"DishLike"];
                 _M_dislike=[d valueForKey:@"DishDisLike"];
                 

                 self.lblLikeCount.text=[[d valueForKey:@"DishLike"]stringValue];
                 self.lblDislikeCount.text=[[d valueForKey:@"DishDisLike"]stringValue];
                 
                 _imgLike.image=[UIImage imageNamed:@"like_orange.png"];
                 _imgDislike.image=[UIImage imageNamed:@"dislike_gray.png"];
                 _lblLikeCount.textColor=[UIColor orangeColor];
                 _lblDislikeCount.textColor=[UIColor grayColor];

                 
             }
             else
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }
         else
         {
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
         [_indicator stopAnimating];
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [Utiles showAlert:self.RestaurantName Message:[error localizedDescription]];
         [self.navigationController popViewControllerAnimated:YES];
     }];
}





//Dislike Dish Menu Web Service

-(void)DislikeWebService
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:self.DishID forKey:@"DishID"];
    [dict setObject:@"2" forKey:@"Task"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [dict setObject:[defaults objectForKey:@"UserID"] forKey:@"UserID"];
    
    [[AFAppAPIClient WSsharedClient] POST:API_SAVE_DISH_LIKE_DISLIKE
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [_indicator startAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             LikeDislikeListArray=[[NSMutableArray alloc]init];
             LikeDislikeListArray=[responseObject objectForKey:@"Data"];
             if(LikeDislikeListArray.count>0)
             {
                 
                 NSDictionary * d = [LikeDislikeListArray objectAtIndex:0];
                 
                 _M_goodLike=[d valueForKey:@"DishLike"];
                 _M_dislike=[d valueForKey:@"DishDisLike"];
                 
                 
                 self.lblLikeCount.text=[[d valueForKey:@"DishLike"]stringValue];
                 self.lblDislikeCount.text=[[d valueForKey:@"DishDisLike"]stringValue];
                 

                 _imgLike.image=[UIImage imageNamed:@"like_gray.png"];
                 _imgDislike.image=[UIImage imageNamed:@"dislike_orange.png"];
                 _lblLikeCount.textColor=[UIColor grayColor];
                 _lblDislikeCount.textColor=[UIColor orangeColor];
             
                 
             }
             else
             {
                 [self.navigationController popViewControllerAnimated:YES];

             }
         }
         else
         {
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
         [_indicator stopAnimating];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [Utiles showAlert:self.RestaurantName Message:[error localizedDescription]];
         [self.navigationController popViewControllerAnimated:YES];
     }];
}


@end
