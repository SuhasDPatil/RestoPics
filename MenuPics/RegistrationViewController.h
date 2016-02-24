//
//  RegistrationViewController.h
//  MenuPics
//
//  Created by Suhas on 23/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCroppingView.h"
#import "Constant.h"
#import "AppDelegate.h"

#import "ImageSelectionView.h"

#import "AFAppAPIClient.h"
#import "SearchViewController.h"

@interface RegistrationViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ImageCroppingViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfermPass;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UIImageView *img_ProfilePic;
@property (strong, nonatomic) IBOutlet UIButton *btnProfileImage;
@property (strong, nonatomic) IBOutlet UIView *viewBorder1;
@property (strong, nonatomic) IBOutlet UIView *viewBorder2;
@property (strong, nonatomic) IBOutlet UIView *viewBorder3;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;




//For Cropping Image
@property (nonatomic,retain) ImageCroppingView *crop_imageView;
@property BOOL isImage;
@property(nonatomic,retain) NSString *selected_image;


//Save Parsed Response
@property(nonatomic,strong)NSString *UserID;

//Alertview
@property(strong,nonatomic)UIAlertView *alt1;



- (IBAction)CancelClicked:(id)sender;
- (IBAction)ProfileImageClicked:(id)sender;
- (IBAction)SignUpClicked:(id)sender;


@end
