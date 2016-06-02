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


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * userID=[defaults objectForKey:@"UserID"];
    
    if ([userID isEqual:@"0"])
    {
        LoginViewController *log=[[LoginViewController alloc]init];
        log.hidesBottomBarWhenPushed=NO;
        log.FromProfileView=@"Profile";
        [self.navigationController pushViewController:log animated:YES];
    }
    else
        
    {
        _lblUserName.text=[defaults valueForKey:@"UserName"];
        //        _lblUserGender.text=[defaults valueForKey:@"Gender"];
        _lblUserEmailID.text=[defaults valueForKey:@"EmailID"];
        //_lblUserPhone.text=[defaults valueForKey:@"UserPhone"];
        _lblUserAddress.text=[defaults valueForKey:@"Address"];
        
        [[self.imgUserPhoto layer] setBorderWidth:4.5];
        [[self.imgUserPhoto layer] setBorderColor:[UIColor whiteColor].CGColor];
        [[self.imgUserPhoto layer]setCornerRadius:(_imgUserPhoto.frame.size.width)/2];
        self.imgUserPhoto.clipsToBounds=YES;
        
        dispatch_async(queue, ^()
        {
            [_indicatorView startAnimating];
            NSString * imgURL = [defaults valueForKey:@"UsersPhoto"];
            NSString *combined = [NSString stringWithFormat:@"%@%@", API_USER_PHOTO,imgURL];
            NSURL * url = [NSURL URLWithString:combined];
            
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
                [_indicatorView stopAnimating];
            });
        });
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
}


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
            [self.tabBarController setSelectedIndex:0];
        }
    }
}


- (IBAction)EditButtonClicked:(id)sender
{
    EditProfileViewController *epvc=[[EditProfileViewController alloc]init];
    [self.navigationController pushViewController:epvc animated:YES];
}

- (IBAction)LogoutClicked:(id)sender
{
    _userid=[NSUserDefaults standardUserDefaults];
    
    [_userid setObject:@"0" forKey:@"UserID"];
    
    LoginViewController *login=[[LoginViewController alloc]init];
    _tab.selectedIndex=2;
    [self.navigationController pushViewController:login animated:YES];
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
