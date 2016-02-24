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

    
    
    _indicatorView.hidden=YES;

    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_bg_green"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_bg_orange"]];
    
    
    _isImage=FALSE;
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    
    [self setSmallBorder:1];
    
    [self setKeyboard];
    
    
    defaults=[NSUserDefaults standardUserDefaults];
    
    _txtUserName.text=[defaults valueForKey:@"UserName"];
//    _txtUserPhone.text=[defaults valueForKey:@"UserPhone"];

    _txtUserPhone.text=@"";
    _txtUserEmail.text=[defaults valueForKey:@"EmailID"];
    _txtAddress.text=@"";
//    _txtCurrentPassword.text=[defaults valueForKey:@"Password"];
    
    
    
    dispatch_async(queue, ^(){
        
        NSString * imgURL = [defaults valueForKey:@"UsersPhoto"];
        NSString *combined = [NSString stringWithFormat:@"%@%@", API_USER_PHOTO,imgURL];
        NSLog(@"User's Photo image URL==%@",combined);
        NSURL * url = [NSURL URLWithString:combined];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imgData];
        dispatch_async( dispatch_get_main_queue() , ^(){
            if (image)
            {
                self.imgUserPhoto.image=image;
            }
            else
            {
                self.imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
            }
            
        });
    });
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
//    [[self.btnCancel layer] setBorderWidth:0.5f];
//    [[self.btnCancel layer] setBorderColor:[UIColor whiteColor].CGColor];
//    [[self.btnCancel layer]setCornerRadius:3.5f];
//    
//    [[self.btnUpdate layer] setBorderWidth:0.5f];
//    [[self.btnUpdate layer] setBorderColor:[UIColor whiteColor].CGColor];
//    [[self.btnUpdate layer]setCornerRadius:3.5f];

    
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_bg_green"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_bg_orange"]];
}

-(void)dismissKeyboard
{
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtAddress resignFirstResponder];
//    [_txtCurrentPassword resignFirstResponder];
    
    [self SlideDownScreen];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






#pragma mark Button Click methods
- (IBAction)CancelClicked:(id)sender
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [_txtAddress resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ProfileImageClicked:(id)sender
{
    [[UIView appearance]setTintColor:[UIColor blackColor]];
    
    NSLog(@"ProfileImageClicked");
    
    
    [_txtAddress resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    
    
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


- (IBAction)UpdateClicked:(id)sender;
{
    NSLog(@"Update Clicked..");
    
    [_txtAddress resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    
    
    [self SlideDownScreen];
    
    _indicatorView.hidden=NO;
    [_indicatorView startAnimating];

    
    if(_txtUserName.text.length==0)
    {
        //    [Utiles showAlert:APP_NAME Message:@"Enter UserName"];
        
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];

        
        UIAlertView * alt=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"Enter User Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        
        return;
    }
    
//    if(_txtUserPhone.text.length==0)
//    {
//        _indicatorView.hidden=YES;
//        [_indicatorView stopAnimating];
//
//        
//        [Utiles showAlert:APP_NAME Message:@"Enter Mobile No."];
//        return;
//    }
//    else  if(_txtUserPhone.text.length<10)
//    {
//        _indicatorView.hidden=YES;
//        [_indicatorView stopAnimating];
//
//        
//        [Utiles showAlert:APP_NAME Message:@"Enter 10 digit mobile number."];
//        return;
//    }
    
    if(_txtUserEmail.text.length==0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];

        [Utiles showAlert:APP_NAME Message:@"Enter Email"];
        return;
    }
    else if (![Utiles validEmail:[_txtUserEmail.text lowercaseString]] )
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];

        [Utiles showAlert:APP_NAME Message:@"Enter Valid Email"];
        return;
    }
    

    
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
//    [_txtPassword resignFirstResponder];
//    [_txtConfermPass resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:_txtUserEmail.text forKey:@"EmailID"];
//    [dict setObject:_txtPassword.text forKey:@"Password"];
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

-(void)checkValidUser:(NSDictionary *)dict{
    
    NSMutableDictionary *valid_dict=[[NSMutableDictionary alloc] init];
    [valid_dict setObject:_txtUserEmail.text forKey:@"UserEmail"];
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
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Utiles showAlert:ERROR Message:[error localizedDescription]];
         
     }];
    
}


-(void)Registerwebservice:(NSDictionary *)dict
{
    defaults=[NSUserDefaults standardUserDefaults];

    NSString * Password=[defaults valueForKey:@"Password"];
    NSNumber * IDD=[defaults valueForKey:@"UserID"];
    
    NSLog(@"%@",IDD);
    
    
    NSMutableDictionary *reg_dict=[[NSMutableDictionary alloc] init];
    [reg_dict setObject:_txtUserEmail.text forKey:@"EmailID"];
    [reg_dict setObject:Password forKey:@"Password"];
    [reg_dict setObject:@"Male" forKey:@"Gender"];
    [reg_dict setObject:@"13" forKey:@"UserAge"];
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
//             [defaults setObject:_UsersPhoto forKey:@"UsersPhoto"];

             NSLog(@"User ID for new user============%@",_UserID);
             
             self.alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"\n Profile Data Updated Successfully..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
             [[UIView appearance] setTintColor:[UIColor darkGrayColor]];
             
             self.alt1.tag=111;
             
//             [self.alt1 show];
             
             [self.navigationController popViewControllerAnimated:YES];

             
             
         }else
         {
             
         }
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
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
        if (buttonIndex==0)
        {
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
                _imgUserPhoto.image=[UIImage imageNamed:@"userPhoto.png"];
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
    _imgUserPhoto.image=image;
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
    [_imgUserPhoto.layer setCornerRadius:(_imgUserPhoto.frame.size.width)/2];
    [_imgUserPhoto.layer setBorderWidth:4.5];
    [_imgUserPhoto.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_imgUserPhoto.layer setMasksToBounds:YES];
    
    NSLog(@"%f",(_imgUserPhoto.frame.size.width)/2);

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
    _txtUserPhone.inputAccessoryView=keyboardToolBar;
    _txtUserEmail.inputAccessoryView=keyboardToolBar;
    _txtAddress.inputAccessoryView=keyboardToolBar;
//    _txtCurrentPassword.inputAccessoryView=keyboardToolBar;
    
}

-(void)doneButtonClicked:(id)sender
{
    [_txtUserName resignFirstResponder];
    [_txtUserPhone resignFirstResponder];
    [_txtUserEmail resignFirstResponder];
    [_txtAddress resignFirstResponder];
//    [_txtCurrentPassword resignFirstResponder];
    
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
            [self.view setFrame:CGRectMake(0, -75,320, self.view.frame.size.height)];
        }
        else if ([_txtUserPhone isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -80, 320, self.view.frame.size.height)];
        }
        else if ([_txtUserEmail isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -130,320,  self.view.frame.size.height)];
        }
        else if ([_txtAddress isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -150,320,  self.view.frame.size.height)];
        }
        
        
        
    }else{
        
        if ([_txtUserName isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -60,320, self.view.frame.size.height)];
        }
        else if ([_txtUserPhone isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -70, 320, self.view.frame.size.height)];
        }
        else if ([_txtUserEmail isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0,  -125,320,  self.view.frame.size.height)];
        }
        else if ([_txtAddress isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0,  -155,320,  self.view.frame.size.height)];
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
