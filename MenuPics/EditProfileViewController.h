//
//  EditProfileViewController.h
//  MenuPics
//
//  Created by rac on 09/06/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCroppingView.h"
#import "Constant.h"
#import "AppDelegate.h"

#import "ImageSelectionView.h"

#import "AFAppAPIClient.h"



@interface EditProfileViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ImageCroppingViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    NSUserDefaults * defaults;
    dispatch_queue_t queue ;

}




@property (strong, nonatomic) IBOutlet UITextField *txtUserName;

@property (strong, nonatomic) IBOutlet UITextField *txtUserPhone;

@property (strong, nonatomic) IBOutlet UITextField *txtUserEmail;

@property (strong, nonatomic) IBOutlet UITextField *txtAddress;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;


@property (strong, nonatomic) IBOutlet UIImageView *imgUserPhoto;


@property (strong, nonatomic) IBOutlet UIButton *btnUserPhoto;

@property (strong, nonatomic) IBOutlet UIButton *btnUpdate;

@property (strong, nonatomic) IBOutlet UIButton *btnCancel;





//For Cropping Image
@property (nonatomic,retain) ImageCroppingView *crop_imageView;
@property BOOL isImage;
@property(nonatomic,retain) NSString *selected_image;


//Alertview
@property(strong,nonatomic)UIAlertView *alt1;


//Save Parsed Response
@property(nonatomic,strong)NSString *UserID;
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *EmailID;
@property(nonatomic,strong)NSString *Gender;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *Password;
@property(nonatomic,strong)NSString *Role;
@property(nonatomic,strong)NSString *SessionID;
@property(nonatomic,strong)NSString *Task;
@property(nonatomic,strong)NSString *UserAge;
@property(nonatomic,strong)NSString *UserPhone;
@property(nonatomic,strong)NSString *UsersPhoto;




- (IBAction)CancelClicked:(id)sender;
- (IBAction)ProfileImageClicked:(id)sender;
- (IBAction)UpdateClicked:(id)sender;



@end
