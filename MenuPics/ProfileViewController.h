//
//  ProfileViewController.h
//  MenuPics
//
//  Created by Suhas on 08/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "EditProfileViewController.h"

@interface ProfileViewController : UIViewController<UIAlertViewDelegate>
{
    dispatch_queue_t queue ;

}

@property(nonatomic,strong)UIAlertView *alt;

@property(nonatomic,retain)UITabBarController *tab;


@property (strong, nonatomic) IBOutlet UILabel *lblUserName;

@property (strong, nonatomic) IBOutlet UILabel *lblUserGender;

@property (strong, nonatomic) IBOutlet UILabel *lblUserEmailID;

@property (strong, nonatomic) IBOutlet UILabel *lblUserPhone;

@property (strong, nonatomic) IBOutlet UILabel *lblUserAddress;

@property (strong, nonatomic) IBOutlet UIImageView *imgUserPhoto;

@property (strong, nonatomic) IBOutlet UIButton *btnEdit;

@property (strong, nonatomic) IBOutlet UIImageView *imgLargePhoto;

@property (strong, nonatomic) NSUserDefaults* userid;

//@property (strong, nonatomic) NSUserDefaults* userphoto;

- (IBAction)EditButtonClicked:(id)sender;

- (IBAction)LogoutClicked:(id)sender;


@end
