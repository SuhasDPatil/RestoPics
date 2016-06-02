//
//  LoginViewController.m
//  MenuPics
//
//  Created by Suhas on 23/04/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//

#import "LoginViewController.h"

#import "SearchViewController.h"
#import "RegistrationViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LoginViewController ()



@end

@implementation LoginViewController

CGSize size;
NSUserDefaults *UserDetails;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_FromProfileView isEqual:@"Profile"])
    {
        _btnSkip.hidden=YES;
    }
    else
    {
        _btnSkip.hidden=NO;
    }
    
    
    _indicatorView.hidden=YES;
    
    UserDetails = [NSUserDefaults standardUserDefaults];
    
    UIColor *color = [UIColor lightTextColor];
    
    _txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Email" attributes:@{NSForegroundColorAttributeName: color}];

    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    
    [[self.btnSignIn layer] setBorderWidth:0.5f];
    [[self.btnSignIn layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.btnSignIn layer]setCornerRadius:3.5f];

    [[self.btnSignUp layer] setBorderWidth:0.5f];
    [[self.btnSignUp layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.btnSignUp layer]setCornerRadius:3.5f];

  
    [[self.viewBorder layer] setBorderWidth:0.8f];
    [[self.viewBorder layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.viewBorder layer]setCornerRadius:3.5f];

    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    
    self.navigationController.navigationBarHidden=YES;

}

// Once the button is clicked, show the login dialog

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login
     logInWithReadPermissions: @[@"public_profile"]
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
    {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled)
         {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
         }
     }];
}


-(void)dismissKeyboard
{
    [_txtUserName resignFirstResponder];
    [_txtPassword resignFirstResponder];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    
    
    self.tabBarController.tabBar.hidden = NO;
    
    _txtUserName.text=@"";
    _txtPassword.text=@"";
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    
    
    NSString * userID=[defaults objectForKey:@"UserID"];

    if (![userID isEqual:@"0"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark Button Click Methods

- (IBAction)SignInclicked:(id)sender
{
    
    [_txtPassword resignFirstResponder];
    [_txtUserName resignFirstResponder];
    
    _indicatorView.hidden=NO;
    [_indicatorView startAnimating];
    
    if(_txtUserName.text.length==0 && _txtPassword.text.length==0)
    {
        [Utiles showAlert:APP_NAME Message:@"Please Enter Email Address & Password "];
        
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        
    }
    else
    {
        [self Loginwebservice];
    }
}

- (IBAction)SignUpClicked:(id)sender
{
    RegistrationViewController * rc = [[RegistrationViewController alloc] init];
    
    [_txtPassword resignFirstResponder];
    [_txtUserName resignFirstResponder];

    [self.navigationController pushViewController:rc animated:YES];
}

- (IBAction)SkipClicked:(id)sender
{
    [_txtPassword resignFirstResponder];
    [_txtUserName resignFirstResponder];

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ForgotPassClicked:(id)sender
{
    [_txtPassword resignFirstResponder];
    [_txtUserName resignFirstResponder];

    ForgotPassViewController * fpvc=[[ForgotPassViewController alloc]init];
    
    [self.navigationController pushViewController:fpvc animated:YES];
}


#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_txtPassword resignFirstResponder];
    [_txtUserName resignFirstResponder];
    
    
    if (self.alt1.tag==111)
    {
        if (buttonIndex==0)
        {
        }
    }
    else if (self.alt1.tag==222)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (self.alt1.tag==333)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


#pragma mark WebServices

-(void)Loginwebservice
{
    
    [_txtUserName resignFirstResponder];
    [_txtPassword resignFirstResponder];
    
    NSString * password=_txtPassword.text;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[_txtUserName.text lowercaseString] forKey:@"EmailID"];
    [dict setObject:password forKey:@"Password"];
    
    
    [self.indicatorView startAnimating];

    
    [[AFAppAPIClient WSsharedClient] POST:API_LOGIN
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _indicatorView.hidden=NO;
         
         NSDictionary *dict_res=(NSDictionary *)responseObject;
         
         NSNumber * isSuccessNumber = (NSNumber *)[dict_res objectForKey: RESULT];
         if([isSuccessNumber boolValue] == YES)
         {
             
             userarray=[responseObject objectForKey:DATA];
             
             NSDictionary *d =[userarray objectAtIndex:0];
             if (d.count>0)
             {
                 
                 _Address=[d valueForKey:@"Address"];
                 _Bio=[d valueForKey:@"Bio"];
                 _CountryCode=[d valueForKey:@"CountryCode"];
                 _EmailID=[d valueForKey:@"EmailID"];
                 _Gender=[d valueForKey:@"Gender"];
                 _Name=[d valueForKey:@"Name"];
                 _Password=[d valueForKey:@"Password"];
                 _Role=[d valueForKey:@"Role"];
                 _SessionID=[d valueForKey:@"SessionID"];
                 _Task=[d valueForKey:@"Task"];
                 _UserAge=[d valueForKey:@"UserAge"];
                 _UserID=[d valueForKey:@"UserID"];
                 _UserName=[d valueForKey:@"UserName"];
                 _UserPhone=[d valueForKey:@"UserPhone"];
                 _UsersPhoto=[d valueForKey:@"UsersPhoto"];
                 AgreeTandS=[d valueForKey:@"AgreeTandS"];
                 
                 
   
                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                 //  [userDefaults setObject:[dict_res objectForKey:DATA] forKey:@"MyData"];
                
                 [userDefaults setObject:[d valueForKey:@"UserID"] forKey:@"UserID"];
                 [userDefaults setObject:_Name forKey:@"UserName"];
                 [userDefaults setObject:_Password forKey:@"Password"];
                 [userDefaults setObject:_EmailID forKey:@"EmailID"];
                 [userDefaults setObject:_UserPhone forKey:@"UserPhone"];
                 [userDefaults setObject:_Address forKey:@"Address"];
                 [userDefaults setObject:_UsersPhoto forKey:@"UsersPhoto"];
                 [userDefaults setObject:_Gender forKey:@"Gender"];
                 [userDefaults setObject:_UserAge forKey:@"UserAge"];
                 [userDefaults setObject:AgreeTandS forKey:@"AgreeTandS"];
                 
                 NSString *active=@"menupics";
                 
                 [userDefaults setObject:active forKey:@"active"];
                 
                 
                 [userDefaults synchronize];
                 
                 [self.indicatorView stopAnimating];

                 
                 [self.navigationController popViewControllerAnimated:YES];
             
             }
         }
         else
         {
             [Utiles showAlert:ERROR Message:@"User Name or Password Incorrect"];
         }
         
         [self.indicatorView stopAnimating];
         _indicatorView.hidden=YES;


     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [Utiles showAlert:ERROR Message:[error localizedDescription]];

     }];
 

}


#pragma mark - TextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
