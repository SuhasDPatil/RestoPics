//
//  RegistrationViewController.m
//  MenuPics
//
//  Created by Suhas on 23/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isImage=FALSE;
    
    [self setSmallBorder:1];

    
    UIColor *color = [UIColor lightTextColor];
    
    _txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    _txtPhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: color}];

    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    _txtConfermPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Repeat" attributes:@{NSForegroundColorAttributeName: color}];

    _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];

    
    [[self.viewBorder1 layer] setBorderWidth:1.0f];
    [[self.viewBorder1 layer] setBorderColor:[UIColor lightTextColor].CGColor];
    [[self.viewBorder1 layer]setCornerRadius:3.5f];

    [[self.viewBorder2 layer] setBorderWidth:1.0f];
    [[self.viewBorder2 layer] setBorderColor:[UIColor lightTextColor].CGColor];
    [[self.viewBorder2 layer]setCornerRadius:3.5f];
    
    [[self.viewBorder3 layer] setBorderWidth:1.0f];
    [[self.viewBorder3 layer] setBorderColor:[UIColor lightTextColor].CGColor];
    [[self.viewBorder3 layer]setCornerRadius:3.5f];

    [[self.btnSignUp layer] setBorderWidth:1.0f];
    [[self.btnSignUp layer] setBorderColor:[UIColor lightTextColor].CGColor];
    [[self.btnSignUp layer]setCornerRadius:2.5f];

    [self setKeyboard];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)dismissKeyboard
{
    [_txtUserName resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtPhoneNumber resignFirstResponder];
    [_txtConfermPass resignFirstResponder];
    [_txtEmail resignFirstResponder];

    [self SlideDownScreen];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_bg_green"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_bg_orange"]];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark Button Click methods
- (IBAction)CancelClicked:(id)sender
{

    [_txtUserName resignFirstResponder];
    [_txtPhoneNumber resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtConfermPass resignFirstResponder];
    [_txtEmail resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (IBAction)ProfileImageClicked:(id)sender
{
    
    [_txtUserName resignFirstResponder];
    [_txtPhoneNumber resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtConfermPass resignFirstResponder];
    [_txtEmail resignFirstResponder];
    
    NSLog(@"ProfileImageClicked");
    
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    NSString *actionSheetTitle = @"Profile Photo";
    NSString *other1 = @"Camera";
    NSString *other2 = @"Gallery";
    NSString *other3 = @"Remove";
    NSString *cancelTitle = @"Cancel";
    
    if(isCamera)
    {
        if (_isImage)
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:actionSheetTitle
                                          delegate:self
                                          cancelButtonTitle:cancelTitle
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:other1, other2,other3, nil];
            
            [actionSheet showInView:self.view];
        }
        else
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:actionSheetTitle
                                          delegate:self
                                          cancelButtonTitle:cancelTitle
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:other1, other2, nil];
            
            [actionSheet showInView:self.view];
        }
    }
    else
    {
        if (_isImage)
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:actionSheetTitle
                                          delegate:self
                                          cancelButtonTitle:cancelTitle
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:other2,other3, nil];
            
            [actionSheet showInView:self.view];
            
        }
        else
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self.navigationController presentViewController:picker animated:YES completion:^{        }];
        }
    }
}

- (IBAction)SignUpClicked:(id)sender
{
    
    [_txtUserName resignFirstResponder];
    [_txtPhoneNumber resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtConfermPass resignFirstResponder];
    [_txtEmail resignFirstResponder];
    
    _indicatorView.hidden=NO;
    [_indicatorView startAnimating];
    [self SlideDownScreen];

    
    
    if(_txtUserName.text.length==0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        UIAlertView * alt=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"Enter User Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        
        return;
    }
    
//    if(_txtPhoneNumber.text.length==0)
//    {
//        _indicatorView.hidden=YES;
//        [_indicatorView stopAnimating];
//        
//        [Utiles showAlert:APP_NAME Message:@"Enter Mobile No."];
//        return;
//    }
//    else  if(_txtPhoneNumber.text.length<10)
//    {
//        _indicatorView.hidden=YES;
//        [_indicatorView stopAnimating];
//        
//        [Utiles showAlert:APP_NAME Message:@"Enter 10 digit mobile number."];
//        return;
//    }
    
    if(_txtEmail.text.length==0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        [Utiles showAlert:APP_NAME Message:@"Enter Email"];
        return;
    }
    else if (![Utiles validEmail:[_txtEmail.text lowercaseString]] )
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        [Utiles showAlert:APP_NAME Message:@"Enter Valid Email"];
        return;
    }
    
    if(_txtPassword.text.length==0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        [Utiles showAlert:APP_NAME Message:@"Enter Password"];
        return;
    }
    
    if(_txtConfermPass.text.length==0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        [Utiles showAlert:APP_NAME Message:@"Enter Confirm Password"];
        return;
    }
    
    
    if(_txtPassword.text.length>0 && _txtConfermPass.text.length>0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        if(![_txtPassword.text isEqualToString:_txtConfermPass.text])
        {
            [Utiles showAlert:APP_NAME Message:@"Confirm Password does not match with Password."];
            return;
        }
    }
    else if(_txtPassword.text.length!= _txtConfermPass.text.length)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        [Utiles showAlert:APP_NAME Message:@"Confirm Password does not match with Password."];
        return;
    }
    
   
    
    //if(self.selected_image.length==0){
    //  [Utiles showAlert:APP_NAME Message:@"Set Profile Photo"];
    //  return;
    //}
    
 
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:_txtEmail.text forKey:@"EmailID"];
    [dict setObject:_txtPassword.text forKey:@"Password"];
    [dict setObject:@"Male" forKey:@"Gender"];
    [dict setObject:@"" forKey:@"UserAge"];
    [dict setObject:_txtPhoneNumber.text forKey:@"UserPhone"];
    [dict setObject:@"2" forKey:@"Role"];
    [dict setObject:[_txtUserName.text lowercaseString] forKey:@"Name"];
    [dict setObject:@"" forKey:@"Address"];
    [dict setObject:@"1" forKey:@"Task"];
    
    if(self.selected_image.length>0)
    {
        [dict setObject:self.selected_image forKey:@"UserPhoto"];
    }
    
    
    
    [self checkValidUser:dict];
    
}

#pragma mark WebServices

-(void)checkValidUser:(NSDictionary *)dict{
    
    NSMutableDictionary *valid_dict=[[NSMutableDictionary alloc] init];
    [valid_dict setObject:_txtEmail.text forKey:@"UserEmail"];
    [valid_dict setObject:[_txtUserName.text lowercaseString] forKey:@"Name"];
    //    [valid_dict setObject:[dict objectForKey:@"MobileNo"] forKey:@"MobileNo"];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_VALID_USER
                               parameters:valid_dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         NSDictionary *dict_res=(NSDictionary *)responseObject;
         
         NSNumber * isSuccessNumber = (NSNumber *)[dict_res objectForKey: RESULT];
         if([isSuccessNumber boolValue] == YES)
         {
             [self Registerwebservice:dict];
             
         }
         else
         {
             NSString *error_message=[self errorMessage:dict_res];
             if(error_message.length>0)
             {
                 [Utiles showAlert:ERROR Message:error_message];
             }
             else
             {
                 [Utiles showAlert:ERROR Message:[dict_res objectForKey: @"Message"]];
             }
         }

     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Utiles showAlert:ERROR Message:[error localizedDescription]];
         
     }];
    
}



-(void)Registerwebservice:(NSDictionary *)dict
{
    NSMutableDictionary *reg_dict=[[NSMutableDictionary alloc] init];
    [reg_dict setObject:_txtEmail.text forKey:@"EmailID"];
    [reg_dict setObject:_txtPassword.text forKey:@"Password"];
    [reg_dict setObject:@"Male" forKey:@"Gender"];
    [reg_dict setObject:@"13" forKey:@"UserAge"];
    [reg_dict setObject:_txtPhoneNumber.text forKey:@"UserPhone"];
    [reg_dict setObject:@"2" forKey:@"Role"];
    [reg_dict setObject:_txtUserName.text forKey:@"Name"];
    [reg_dict setObject:@"Pune" forKey:@"Address"];
    [reg_dict setObject:@"1" forKey:@"Task"];

    if(self.selected_image.length>0)
    {
        [reg_dict setObject:self.selected_image forKey:@"UsersPhoto"];
    }
    
    
    //Remaining Fields
    [reg_dict setObject:@"0" forKey:@"UserID"];
    
    [self.indicatorView startAnimating];

    
    [[AFAppAPIClient WSsharedClient] POST:API_REGISTER
                               parameters:reg_dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         NSDictionary *dict_res=(NSDictionary *)responseObject;
         
         
//         NSMutableDictionary * dataArray=[dict_res objectForKey:@"Data"];
//         
//         NSString * userId=(NSString *)[dict_res objectForKey:DATA];
         
         NSNumber * isSuccessNumber = (NSNumber *)[dict_res objectForKey: RESULT];
         
         if([isSuccessNumber boolValue] == YES)
         {
//             [self DoLogin];
             
            
             NSMutableArray * UserIDList=[responseObject objectForKey:DATA];
        
             NSLog(@"Restaurant Array Count:::%ld",(unsigned long)UserIDList.count);
             int i;
             for (i=0; i<UserIDList.count; i++)
             {
                 NSDictionary * d = [UserIDList objectAtIndex:i];
                 
                 _UserID=[d valueForKey:@"UserID"];
                 
             }
             
             NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
             
             [defaults setObject:_UserID forKey:@"UserID"];

             NSLog(@"User ID for new user============%@",_UserID);
             
             self.alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"\n Registration Successful..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
             [[UIView appearance] setTintColor:[UIColor darkGrayColor]];

             self.alt1.tag=111;
//             [self.alt1 show];
             
             [self.navigationController popViewControllerAnimated:YES];


    
         }else
         {
             
         }
         
         
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Utiles showAlert:ERROR Message:[error localizedDescription]];
         
     }];
    
    [self.indicatorView stopAnimating];
    
}


-(void)DoLogin{
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[_txtEmail.text lowercaseString] forKey:@"EmailID"];
    [dict setObject:_txtPassword.text forKey:@"Password"];
    [[AFAppAPIClient WSsharedClient] POST:API_LOGIN
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         NSDictionary *dict_res=(NSDictionary *)responseObject;
         
         NSNumber * isSuccessNumber = (NSNumber *)[dict_res objectForKey: RESULT];
         
         if([isSuccessNumber boolValue] == YES)
         {
             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
             [userDefaults setObject:[dict_res objectForKey:DATA] forKey:@"Data"];
             
             [userDefaults setObject:_txtUserName.text forKey:@"UserName"];
             [userDefaults setObject:_txtPassword.text forKey:@"Password"];
             [userDefaults setObject:_UserID forKey:@"UserID"];

             [userDefaults synchronize];
             
             
             SearchViewController *srch=[[SearchViewController alloc]init];
             
             [self.navigationController pushViewController:srch animated:YES];
             
         }
         else
         {
             [Utiles showAlert:APP_NAME Message:@"Login fail."];
         }
         
         
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Utiles showAlert:ERROR Message:[error localizedDescription]];
         
     }];
}



-(NSString *)errorMessage:(NSDictionary *)dict
{
    NSString *error=@"";
    NSArray *data=[dict objectForKey:DATA];
    NSMutableArray *message_array=[[NSMutableArray alloc] init];
    if([data count]>0)
    {
        NSDictionary *data_dict=[data objectAtIndex:0];
        if([[data_dict objectForKey:@"EmailID"] intValue]>0)
        {
            [message_array addObject:@"EmailID"];
        }
        if([[data_dict objectForKey:@"MobileNo"] intValue]>0)
        {
            [message_array addObject:@"MobileNo"];
        }
        if([[data_dict objectForKey:@"UserName"] intValue]>0)
        {
            [message_array addObject:@"UserName"];
        }
        for (int i=0;i<[message_array count];  i++)
        {
            
            if([message_array count]==1 || [message_array count]==(i+1))
            {
                error = [error stringByAppendingString:[message_array objectAtIndex:i]];
            }
            else
            {
                error = [error stringByAppendingString:[NSString stringWithFormat:@"%@, ",[message_array objectAtIndex:i]]];
            }
        }
        if(error.length>0 && [message_array count]>1)
        {
            error = [error stringByAppendingString:@" combination already exits."];
        }
        else  if(error.length>0 && [message_array count]==1)
        {
            error = [error stringByAppendingString:@" already exits."];
        }
    }
    return error;
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.alt1.tag==111)
    {
        if (buttonIndex==1)
        {
//            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            
            NSUserDefaults * defa=[NSUserDefaults standardUserDefaults];
            
            [defa setObject:@"0" forKey:@"UserID"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
        
}


#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger i = buttonIndex;
    
    switch(i)
    {
        case 0:
        {
            
            BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            if(isCamera){
                UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
                [self.navigationController presentViewController:picker animated:YES completion:^{}];
            }else{
                UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self.navigationController presentViewController:picker animated:YES completion:^{}];
            }
        }
            break;
        case 1:
        {
            BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            if(isCamera){
                
                UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self.navigationController presentViewController:picker animated:YES completion:^{}];
            }else{
                _img_ProfilePic.image=[UIImage imageNamed:@"userPhoto.png"];
                self.selected_image=@"";
                _isImage=FALSE;
            }
        }
            
        case 2:
        {
            if (_img_ProfilePic==nil) {
                _img_ProfilePic.image=[UIImage imageNamed:@""];
            }
            _img_ProfilePic.image=[UIImage imageNamed:@"userPhoto.png"];
        
            self.selected_image=@"";
            _isImage=FALSE;
        }
            break;
        default:
            
            break;
    }
    
}



#pragma - mark Selecting Image from Camera and Library

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    _isImage=TRUE;
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UIImage *resize=[self processImage:selectedImage];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.crop_imageView=[[ImageCroppingView alloc] initWithNibName:@"ImageCroppingView" bundle:nil];
    
    self.crop_imageView.delegate=self;
    
    self.crop_imageView.input_Image=resize;
    
    self.crop_imageView.isProfileImage=TRUE;
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    [appDelegate.window addSubview:self.crop_imageView.view];
    [self addChildViewController:self.crop_imageView];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}

-(UIImage *) processImage:(UIImage *)org_img{
    
    @try {
        
        
        UIImage *rotatedImage;
        
        if (org_img.imageOrientation != UIImageOrientationUp)
        {
            UIGraphicsBeginImageContextWithOptions(org_img.size, NO, org_img.scale);
            
            [org_img drawInRect:(CGRect){0, 0, org_img.size}];
            
            rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
        }
        else
        {
            rotatedImage = org_img;
        }
        
        return rotatedImage;
    }
    @catch (NSException *exception) {
        
        
    }
}

-(void)imageIsDoneCropping:(UIImage *)image{
    _img_ProfilePic.image=image;
    self.selected_image=[Utiles encodeToBase64String:image];
    [self canceledCroppingImage];
}
-(void)canceledCroppingImage{
    [self.crop_imageView.view removeFromSuperview];
    [self.crop_imageView removeFromParentViewController];
}


#pragma mark UITextFieldDelegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[UIView appearance]setTintColor:[UIColor whiteColor]];

        [self SlideupScreen:textField];
        return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self SlideDownScreen];
    [textField resignFirstResponder];
    return YES;
}





#pragma mark User Defined

-(void) setSmallBorder:(int)width{
    [_img_ProfilePic.layer setCornerRadius:(_img_ProfilePic.frame.size.width)/2];
    [_img_ProfilePic.layer setBorderWidth:4.5];
    [_img_ProfilePic.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_img_ProfilePic.layer setMasksToBounds:YES];
    
    self.title=@"Create an account";
}


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
    
    _txtUserName.inputAccessoryView=keyboardToolBar;
    _txtPassword.inputAccessoryView=keyboardToolBar;
    _txtPhoneNumber.inputAccessoryView=keyboardToolBar;
    _txtConfermPass.inputAccessoryView=keyboardToolBar;
    _txtEmail.inputAccessoryView=keyboardToolBar;
    
}

-(void)doneButtonClicked:(id)sender
{
    [_txtUserName resignFirstResponder];
    [_txtPhoneNumber resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtConfermPass resignFirstResponder];
    [_txtEmail resignFirstResponder];
    
    [self SlideDownScreen];
    
    
    // for ios 6
    
    // for ios 7
    // CGPoint scrollPoint = CGPointMake(0, self.view.frame.origin.y-65);
    // [scrollView setContentOffset:scrollPoint animated:YES];
}


-(void)SlideupScreen:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    if ([[UIScreen mainScreen] bounds].size.height ==480)
    {
        if ([_txtUserName isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -90,320, self.view.frame.size.height)];
        }
        else if ([_txtPhoneNumber isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -90, 320, self.view.frame.size.height)];
        }
        else if ([_txtEmail isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -165,320,  self.view.frame.size.height)];
        }
        else if ([_txtPassword isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -160,320,  self.view.frame.size.height)];
        }
        else if ([_txtConfermPass isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -205,320,  self.view.frame.size.height)];
        }
        
            
        
    }else{
        
        if ([_txtUserName isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -50,320, self.view.frame.size.height)];
        }
        else if ([_txtPhoneNumber isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -60, 320, self.view.frame.size.height)];
        }
        else if ([_txtEmail isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0,  -120,320,  self.view.frame.size.height)];
        }
        else if ([_txtPassword isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0,  -125,320,  self.view.frame.size.height)];
        }
        else if ([_txtConfermPass isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0,  -205,320,  self.view.frame.size.height)];
        }
    }
    
    [UIView commitAnimations];
}

-(void)SlideDownScreen{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    [self.view setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    
    [UIView commitAnimations];
    
}

#pragma mark Keyboard Delegates Methods
- (void)keyboardDidShow:(NSNotification *)notification
{
    //[self SlideupScreen];
}


-(void)keyboardDidHide:(NSNotification *)notification
{
    [self SlideDownScreen];
}


@end
