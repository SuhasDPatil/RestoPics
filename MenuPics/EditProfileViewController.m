//
//  EditProfileViewController.m
//  MenuPics
//
//  Created by rac on 09/06/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
    _isImage=FALSE;
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    [self setSmallBorder:1];
    
    defaults=[NSUserDefaults standardUserDefaults];
    
    _txtUserName.text=[defaults valueForKey:@"UserName"];
    _txtUserPhone.text=[defaults valueForKey:@"UserPhone"];

   // _txtUserPhone.text=@"";
    _txtUserEmail.text=[defaults valueForKey:@"EmailID"];
    _txtAddress.text=[defaults valueForKey:@"Address"];
    _textpassword.text=[defaults valueForKey:@"Password"];
    _textRepeatpass.text=[defaults valueForKey:@"Password"];
    
    
    
//    dispatch_async(queue, ^(){
//        
//        [_indicatorViewProfile startAnimating];
//        
//        NSString * imgURL = [defaults valueForKey:@"UsersPhoto"];
//        NSString *combined = [NSString stringWithFormat:@"%@%@", API_USER_PHOTO,imgURL];
//        NSURL * url = [NSURL URLWithString:combined];
//        NSData * imgData = [NSData dataWithContentsOfURL:url];
//        UIImage * image = [UIImage imageWithData:imgData];
//        dispatch_async( dispatch_get_main_queue() , ^(){
//            if (image)
//            {
//                self.imgUserPhoto.image=image;
//            }
//            else
//            {
//                self.imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
//            }
//            [_indicatorViewProfile stopAnimating];
//        });
//    });
    
    
    NSString * imgURL = [defaults valueForKey:@"UsersPhoto"];
    NSString *replacedStr = [NSString stringWithFormat:@"%@%@", API_USER_PHOTO,imgURL];
    
    NSString * reps=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
    
    NSString * combined=[reps stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [_indicatorViewProfile startAnimating];

    [self.operationManager GET: combined
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           self.imgUserPhoto.image = responseObject;
                           [_indicatorViewProfile stopAnimating];
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           NSLog(@"Failed with error %@.", error);
                       }];
    

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

-(void)viewWillAppear:(BOOL)animated
{
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
}

-(void)dismissKeyboard
{
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtAddress resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark Button Click methods
- (IBAction)CancelClicked:(id)sender
{
    [_txtAddress resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ProfileImageClicked:(id)sender
{
    
    [_txtAddress resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    
    
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    NSString *actionSheetTitle = @"Profile Photo";
    NSString *Camera = @"Camera";
    NSString *Gallery = @"Gallery";
    NSString *Remove = @"Remove";
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
                                          otherButtonTitles:Camera, Gallery,Remove, nil];
            actionSheet.tag=100;
            
            [actionSheet showInView:self.view];
        }
        else
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:actionSheetTitle
                                          delegate:self
                                          cancelButtonTitle:cancelTitle
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:Camera, Gallery, nil];
            actionSheet.tag=101;
            
            
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
                                          otherButtonTitles:Gallery,Remove, nil];
            actionSheet.tag=200;

            [actionSheet showInView:self.view];
            
        }
        else
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self.navigationController presentViewController:picker animated:YES completion:^{
            
            }];
        }
    }
}



#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger i = buttonIndex;
    if (actionSheet.tag==100)
    {
        
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
//                    _imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
                    self.selected_image=@"";
                    _isImage=FALSE;
                }
            }
                
            case 2:
            {
                if (_imgUserPhoto==nil) {
                    _imgUserPhoto.image=[UIImage imageNamed:@""];
                }
                _imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
                
                self.selected_image=@"";
                _isImage=FALSE;
            }
                break;
            default:
                
                break;
        }
    }
    
    else if (actionSheet.tag==101)
    {
        
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
//                    _imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
                    self.selected_image=@"";
                    _isImage=FALSE;
                }
            }
            default:
                break;
        }
    }
    else if (actionSheet.tag==200)
    {
        
        switch(i)
        {
            case 0:
            {
                BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                if(isCamera){
                    
                    UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
                    picker.delegate = self;
                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self.navigationController presentViewController:picker animated:YES completion:^{}];
                }else{
//                    _imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
                    self.selected_image=@"";
                    _isImage=FALSE;
                }
            }
                
            case 1:
            {
                if (_imgUserPhoto==nil) {
                    _imgUserPhoto.image=[UIImage imageNamed:@""];
                }
                _imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
                
                self.selected_image=@"";
                _isImage=FALSE;
            }
                break;
            default:
                
                break;
        }
        
    }

    
}



- (IBAction)UpdateClicked:(id)sender;
{
    [_txtAddress resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    [_textpassword resignFirstResponder];
    [_textRepeatpass resignFirstResponder];
    

    
    if(_txtUserName.text.length==0)
    {

        UIAlertView * alt=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"Enter User Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        
        return;
    }
    long len=_txtUserPhone.text.length;

    if (len==0 || len>9)
    {
        NSLog(@"%ld",len);
        
    }
    else
    {
        
        [Utiles showAlert:APP_NAME Message:@"Enter Valid Phone Number"];
        return;
    }
    
    

    if(_txtUserEmail.text.length==0)
    {

        [Utiles showAlert:APP_NAME Message:@"Enter Email"];
        return;
    }
     if (![Utiles validEmail:[_txtUserEmail.text lowercaseString]] )
    {

        [Utiles showAlert:APP_NAME Message:@"Enter Valid Email"];
        return;
    }
    if(_textpassword.text.length==0)
    {
        
        [Utiles showAlert:APP_NAME Message:@"Enter Password"];
        return;
    }
    else if (_textpassword.text.length<6)
    {
        
        [Utiles showAlert:APP_NAME Message:@"Minimum Password Length should be 6 digit"];
        return;
    }

    
    if(_textRepeatpass.text.length==0)
    {
        
        [Utiles showAlert:APP_NAME Message:@"Enter Confirm Password"];
        return;
    }

    
    
    if(_textpassword.text.length>0 && _textRepeatpass.text.length>0)
    {
        
        if(![_textpassword.text isEqualToString:_textRepeatpass.text])
        {
            [Utiles showAlert:APP_NAME Message:@"Confirm Password does not match with Password."];
            return;
        }
    }
    else if(_textpassword.text.length!= _textRepeatpass.text.length)
    {
        
        [Utiles showAlert:APP_NAME Message:@"Confirm Password does not match with Password."];
        return;
    }

    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:_txtUserEmail.text forKey:@"EmailID"];
    [dict setObject:_textpassword forKey:@"Password"];
    [dict setObject:@"Male" forKey:@"Gender"];
    [dict setObject:@"" forKey:@"UserAge"];
    [dict setObject:_txtUserPhone.text forKey:@"UserPhone"];
    [dict setObject:@"2" forKey:@"Role"];
    [dict setObject:[_txtUserName.text lowercaseString] forKey:@"Name"];
    [dict setObject:_txtAddress.text forKey:@"Address"];
    [dict setObject:@"2" forKey:@"Task"];
    
    if(self.selected_image.length>0)
    {
        [dict setObject:self.selected_image forKey:@"UserPhoto"];
    }
    [self Registerwebservice:dict];
    
}


#pragma mark Web-Service Functionality

-(void)checkValidUser:(NSDictionary *)dict
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableDictionary *valid_dict=[[NSMutableDictionary alloc] init];
    [valid_dict setObject:_txtUserEmail.text forKey:@"UserEmail"];
    [valid_dict setObject:[_txtUserName.text lowercaseString] forKey:@"Name"];
    [valid_dict setObject:_textpassword.text forKey:@"Password"];
    //    [valid_dict setObject:[dict objectForKey:@"MobileNo"] forKey:@"MobileNo"];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_VALID_USER
                               parameters:valid_dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [hud show:YES];
         
         
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
         [hud hide:YES];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Utiles showAlert:ERROR Message:[error localizedDescription]];
         
     }];
}


-(void)Registerwebservice:(NSDictionary *)dict
{
    defaults=[NSUserDefaults standardUserDefaults];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    NSNumber * IDD=[defaults valueForKey:@"UserID"];
    
    NSMutableDictionary *reg_dict=[[NSMutableDictionary alloc] init];
    [reg_dict setObject:_txtUserEmail.text forKey:@"EmailID"];
    [reg_dict setObject:_textpassword.text forKey:@"Password"];
    [reg_dict setObject:@"Male" forKey:@"Gender"];
    [reg_dict setObject:@"23" forKey:@"UserAge"];
    [reg_dict setObject:_txtUserPhone.text forKey:@"UserPhone"];
    [reg_dict setObject:@"2" forKey:@"Role"];
    [reg_dict setObject:_txtUserName.text forKey:@"Name"];
    [reg_dict setObject:_txtAddress.text forKey:@"Address"];
    [reg_dict setObject:@"2" forKey:@"Task"];
    
    if(self.selected_image.length>0)
    {
        [reg_dict setObject:self.selected_image forKey:@"UsersPhoto"];
    }
    //Remaining Fields
    [reg_dict setObject:IDD forKey:@"UserID"];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_REGISTER
                               parameters:reg_dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         [hud show:YES];
         
         
         NSDictionary *dict_res=(NSDictionary *)responseObject;
         
         NSNumber * isSuccessNumber = (NSNumber *)[dict_res objectForKey: RESULT];
         if([isSuccessNumber boolValue] == YES)
         {
             NSMutableArray * UserIDList=[responseObject objectForKey:DATA];
             
             int i;
             for (i=0; i<UserIDList.count; i++)
             {
                 NSDictionary * d = [UserIDList objectAtIndex:i];
                 
                 _UserID=[d valueForKey:@"UserID"];
                 _Address=[d valueForKey:@"Address"];
                 _EmailID=[d valueForKey:@"EmailID"];
                 _Gender=[d valueForKey:@"Gender"];
                 _Name=[d valueForKey:@"Name"];
                 _Password=[d valueForKey:@"Password"];
                 _Role=[d valueForKey:@"Role"];
                 _SessionID=[d valueForKey:@"SessionID"];
                 _Task=[d valueForKey:@"Task"];
                 _UserAge=[d valueForKey:@"UserAge"];
                 _UserPhone=[d valueForKey:@"UserPhone"];
                 _UsersPhoto=[d valueForKey:@"UsersPhoto"];
              
             }
             [defaults setObject:_UserID forKey:@"UserID"];
             [defaults setObject:_Name forKey:@"UserName"];
             [defaults setObject:_Password forKey:@"Password"];
             [defaults setObject:_EmailID forKey:@"EmailID"];
             [defaults setObject:_UserPhone forKey:@"UserPhone"];
             [defaults setObject:_Address forKey:@"Address"];
             
             [defaults setObject:_UsersPhoto forKey:@"UsersPhoto"];
             
             [self.navigationController popViewControllerAnimated:YES];
         }else
         {
             
         }
         
         [hud hide:YES];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error){
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
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
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
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];

    
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
    _imgUserPhoto.image=image;
    self.selected_image=[Utiles encodeToBase64String:image];
    [self canceledCroppingImage];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];

    
}
-(void)canceledCroppingImage{
    [self.crop_imageView.view removeFromSuperview];
    [self.crop_imageView removeFromParentViewController];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
}


#pragma mark UITextFieldDelegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    [[UIView appearance]setTintColor:[UIColor whiteColor]];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark User Defined

-(void) setSmallBorder:(int)width{
    [_imgUserPhoto.layer setCornerRadius:(_imgUserPhoto.frame.size.width)/2];
    [_imgUserPhoto.layer setBorderWidth:4.5];
    [_imgUserPhoto.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_imgUserPhoto.layer setMasksToBounds:YES];
    

}



@end
