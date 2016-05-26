    //
//  ProfileViewController.m
//  MenuPics
//
//  Created by Suhas on 08/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [self setNavBar];
    
//    self.title=@"My Profile";
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial Rounded MT Bold" size:14],NSFontAttributeName, nil]];

    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
    NSLog(@"Will Appear");
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    
    NSString * userID=[defaults objectForKey:@"UserID"];
    
    NSString *userphoto=[defaults objectForKey:@"UsersPhoto"];
    
    NSLog(@"user photo ==   %@",userphoto);

    
    
    if ([userID isEqual:@"0"])
    {
        
        LoginViewController *log=[[LoginViewController alloc]init];
        
        log.hidesBottomBarWhenPushed=NO;
        
        log.FromProfileView=@"Profile";
        
        NSLog(@"%@",log.FromProfileView);
        
        [self.navigationController pushViewController:log animated:YES];
    }
    else
        
    {
        NSLog(@"Profile View with Login Id %@ ",[defaults valueForKey:@"UserID"]);
        _lblUserName.text=[defaults valueForKey:@"UserName"];
        //        _lblUserGender.text=[defaults valueForKey:@"Gender"];
        _lblUserEmailID.text=[defaults valueForKey:@"EmailID"];
        //_lblUserPhone.text=[defaults valueForKey:@"UserPhone"];
        _lblUserAddress.text=[defaults valueForKey:@"Address"];
        
        NSString *userphoto=[defaults objectForKey:@"UsersPhoto"];
        NSString *active=[defaults objectForKey:@"Active"];
        
        NSLog(@"user photo ==   %@",userphoto);
        
         NSLog(@"Active ==   %@",active);

        
        [[self.imgUserPhoto layer] setBorderWidth:4.5];
        [[self.imgUserPhoto layer] setBorderColor:[UIColor whiteColor].CGColor];
        [[self.imgUserPhoto layer]setCornerRadius:(_imgUserPhoto.frame.size.width)/2];
        self.imgUserPhoto.clipsToBounds=YES;
        
        NSLog(@"%f",(_imgUserPhoto.frame.size.width)/2);
        
        
        
        dispatch_async(queue, ^()
        {
            
            
            NSString * imgURL = [defaults valueForKey:@"UsersPhoto"];
           
            
            NSString *combined = [NSString stringWithFormat:@"%@%@", API_USER_PHOTO,imgURL];
            NSLog(@"User's Photo image URL==%@",combined);
            NSURL * url = [NSURL URLWithString:combined];
//            NSString * imgURL = [defaults valueForKey:@"UsersPhoto"];
//            NSString *active=[defaults valueForKey:@"Active"];
            
        
            
            NSData * imgData = [NSData dataWithContentsOfURL:url];
            UIImage * image = [UIImage imageWithData:imgData];
            dispatch_async( dispatch_get_main_queue() , ^(){
                if (image)
                {
                    self.imgUserPhoto.image=image;
                    self.imgLargePhoto.image=image;
                }
                else
                {
                    self.imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
                }
                
            });
        
        });
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==101)
    {
        if (buttonIndex==1)
        {
            
            LoginViewController *log=[[LoginViewController alloc]init];
            log.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:log animated:YES];
            
        }
        else
        {
            NSLog(@"Cancel Clicked...");
            [self.tabBarController setSelectedIndex:0];
        }
    }
}


- (IBAction)EditButtonClicked:(id)sender
{
    EditProfileViewController *epvc=[[EditProfileViewController alloc]init];
    
    
    
    
    [self.navigationController pushViewController:epvc animated:YES];
}

- (IBAction)LogoutClicked:(id)sender {
    
    
    _userid=[NSUserDefaults standardUserDefaults];
    
    
    
    [_userid setObject:@"0" forKey:@"UserID"];
    
   // [_userphoto setObject:@"" forKey:@"Users"]

    
    LoginViewController *login=[[LoginViewController alloc]init];

    _tab.selectedIndex=2;

    
    [self.navigationController pushViewController:login animated:YES];
    
    //self.imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];

    
    
//    if ( [[MPUser activeUser] loggedIn]==false)
//    {
//        NSLog(@"Logout");
//    }
//    else
//    {
//        NSLog(@"Active");
//    }
    
    
//    _lblUserName.text=nil;
//    _lblUserEmailID.text=nil;
//    _lblUserPhone.text=nil;
//    _lblUserAddress.text=nil;
 
//
//    
//    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
//    
//    [defaults setObject:@"0" forKey:@"Inactive"];
    
    
    
    
//
//    
//    
//    
//    LoginViewController * lvc=[[LoginViewController alloc]init];
//    
//    [self.navigationController pushViewController:lvc animated:YES];
    
}

#pragma mark User Defined
-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    //    [self.navigationController.navigationBar
    //     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15],NSFontAttributeName, nil]];
    
}


@end
