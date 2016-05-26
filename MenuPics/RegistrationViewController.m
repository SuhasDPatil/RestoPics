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
 
    
    checkboxselected=@"";
    
    
    
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

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
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

    
    
    if(_txtUserName.text.length==0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        UIAlertView * alt=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"Enter User Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        
        return;
    }
    
    
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
    
    if(_btncheckbox.selected==NO)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
        [Utiles showAlert:APP_NAME Message:@"Confirm Terms of Services"];
        
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
    [dict setObject:@"0" forKey:@"AgreeTandS"];
    
   
    
    
    
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
    [reg_dict setObject:@"" forKey:@"Address"];
    [reg_dict setObject:@"1" forKey:@"Task"];
    [reg_dict setObject:@"0" forKey:@"AgreeTandS"];

    
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
             
            
             NSMutableArray * UserIDList=[responseObject objectForKey:DATA];
        
             NSLog(@"Restaurant Array Count:::%ld",(unsigned long)UserIDList.count);
             int i;
             for (i=0; i<UserIDList.count; i++)
             {
                 NSDictionary * d = [UserIDList objectAtIndex:i];
                 
                 _UserID=[d valueForKey:@"UserID"];
                 _Username=[d valueForKey:@"Name"];
                 _Email=[d valueForKey:@"EmailID"];
                 _Address=[d valueForKey:@"Address"];
                 _Phone=[d valueForKey:@"UserPhone"];
                 _Password=[d valueForKey:@"Password"];
                 _userphoto=[d valueForKey:@"UsersPhoto"];
                 
             }
             NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
             [defaults setObject:_UserID forKey:@"UserID"];
             [defaults setObject:_Username forKey:@"UserName"];
             [defaults setObject:_Email forKey:@"EmailID"];
             [defaults setObject:_Address  forKey:@"Address"];
             [defaults setObject:_Phone forKey:@"UserPhone"];
             [defaults setObject:_Password forKey:@"Password"];
             [defaults setObject:_userphoto forKey:@"UsersPhoto"];
             
             
             
             [defaults synchronize];
             
             
             NSLog(@"User ID for new user============%@",_UserID);
             
            
             
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
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
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


#pragma mark Keyboard Delegates Methods
- (void)keyboardDidShow:(NSNotification *)notification
{
}


-(void)keyboardDidHide:(NSNotification *)notification
{
}


- (IBAction)btnactionchkbox:(id)sender
{
    _btncheckbox.selected=!_btncheckbox.selected;
    
    if (_btncheckbox.selected==YES)
    {
        
        [_btncheckbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
        
        

         NSLog(@"Selceted");
        
        checkboxselected=@"Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service \n By accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service \n\n Accounts \n\n When you create an account with us, you must provide us information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.";
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service \n By accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service \n\n Accounts \n\n When you create an account with us, you must provide us information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service. \n You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your password, whether your password is with our Service or a third-party service \n You agree not to disclose your password to any third party. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account. \n\n Links To Other Web Sites \n\n Our Service may contain links to third-party web sites or services that are not owned or controlled by MenuPics.\n MenuPics has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that MenuPics shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such web sites or services.\n\n We strongly advise you to read the terms and conditions and privacy policies of any third-party web sites or services that you visit. \n\n Termination \n\n   We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms \n All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability. \n We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms \n Upon termination, your right to use the Service will immediately cease. If you wish to terminate your account, you may simply discontinue using the Service. \n All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.\n\n Governing Law \n\n These Terms shall be governed and construed in accordance with the laws of Illinois, United States, without regard to its conflict of law provisions.\n Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service, and supersede and replace any prior agreements we might have between us regarding the Service.\n\n Changes \n\n We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will try to provide at least 30 days notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.\n By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, please stop using the Service. \n\n Contact Us \n\n If you have any questions about these Terms, please contact us.\n   " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        
        [alert show];
    }
    else if (_btncheckbox.selected==NO)
    {
            [_btncheckbox setImage:[UIImage imageNamed:@"uncheckbox.png"] forState:UIControlStateNormal];

             NSLog(@"un selected");
            
            checkboxselected=@"";
    }
}

@end
