//
//  LoginViewController.h
//  MenuPics
//
//  Created by Suhas on 23/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"



#import "ForgotPassViewController.h"
//#define TWITTER_CLIENT_KEY @"uSx6bs0NXR21iHukpjec1PP9o"
//#define TWITTER_CLIENT_SECRET @"vrLjSfuII28nH99rAUgP3qbRdySjSigiGlcA8O6wG72XbliNXO"


@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate>//FBLoginViewDelegate
{
    dispatch_queue_t queue ;
    
    NSMutableArray * userarray;
    
    NSString *AgreeTandS;

}

@property(nonatomic)BOOL * isFromProfile;


@property (strong, nonatomic) IBOutlet UIView *view;


@property (strong, nonatomic) IBOutlet UIButton *btnSkip;

@property (strong, nonatomic) IBOutlet UIView *viewBorder;

@property (strong, nonatomic) IBOutlet UITextField *txtUserName;

@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;

@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;

@property (strong, nonatomic) IBOutlet UIButton *btnForgotPassword;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;






@property(strong,nonatomic)NSString * emailForgotPass;
@property(strong,nonatomic)UITextField * emailAddress;

- (IBAction)SignInclicked:(id)sender;

- (IBAction)SignUpClicked:(id)sender;

- (IBAction)SkipClicked:(id)sender;

- (IBAction)ForgotPassClicked:(id)sender;



@property(strong,nonatomic)NSString *FromProfileView;


//Parsed User Data
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *Bio;
@property(nonatomic,strong)NSString *CountryCode;
@property(nonatomic,strong)NSString *EmailID;
@property(nonatomic,strong)NSString *Gender;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *Password;
@property(nonatomic,strong)NSString *Role;
@property(nonatomic,strong)NSString *SessionID;
@property(nonatomic,strong)NSString *Task;
@property(nonatomic,strong)NSString *UserAge;
@property(nonatomic)NSNumber * UserID;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *UserPhone;
@property(nonatomic,strong)NSString *UsersPhoto;



//Alertview
@property(strong,nonatomic)UIAlertView *alt1;



@end
