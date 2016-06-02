//
//  ForgotPassViewController.m
//  MenuPics
//
//  Created by rac on 24/09/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import "ForgotPassViewController.h"

@interface ForgotPassViewController ()

@end

@implementation ForgotPassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _indicatorView.hidden=YES;

    
    [[self.viewBorder layer] setBorderWidth:0.8f];
    [[self.viewBorder layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.viewBorder layer]setCornerRadius:3.5f];
    
    [[self.btnSend layer] setBorderWidth:0.8f];
    [[self.btnSend layer] setBorderColor:[UIColor clearColor].CGColor];
    [[self.btnSend layer]setCornerRadius:3.5f];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    self.navigationController.navigationBarHidden=YES;
    
    // Do any additional setup after loading the view from its nib.
}



-(void)dismissKeyboard
{
    [_txtEmailAddress resignFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendClicked:(id)sender
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    _indicatorView.hidden=NO;
    [_indicatorView startAnimating];
    
    
    if(_txtEmailAddress.text.length==0)
    {
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];

        
        [alert showWarning:self title:APP_NAME subTitle:@"Enter Email Address" closeButtonTitle:@"OK" duration:0.0f];

        
        return;
    }
    else if (![Utiles validEmail:[_txtEmailAddress.text lowercaseString]] )
    {
        
        [alert showWarning:self title:APP_NAME subTitle:@"Enter Valid Email Address" closeButtonTitle:@"OK" duration:0.0f];
        _indicatorView.hidden=YES;
        [_indicatorView stopAnimating];
        return;
    }
    else
    {
        [self ForgotPassWebService];
    }
    
}

- (IBAction)returnLoginClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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


#pragma mark WebServices


-(void)ForgotPassWebService
{
    
    
    
    [_txtEmailAddress resignFirstResponder];
    
    NSString * emailID=_txtEmailAddress.text;
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:emailID forKey:@"Username"];
    
    [self.indicatorView startAnimating];

    [[AFAppAPIClient WSsharedClient] POST:API_FORGOT_PASS
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         NSDictionary *dict_res=(NSDictionary *)responseObject;
         
         NSNumber * isSuccessNumber = (NSNumber *)[dict_res objectForKey: RESULT];
         if([isSuccessNumber boolValue] == YES)
         {
             
//             [Utiles showAlert:APP_NAME Message:@"UserName and Password sent successfully on your mail..\n Thank you!!!"];

             _txtEmailAddress.text=@"";
             
             UIAlertView * alt=[[UIAlertView alloc]initWithTitle:APP_NAME message:@"UserName and Password sent successfully on your mail..\n Thank you!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             alt.tag=100;
             [alt show];
             
             
             [self.indicatorView stopAnimating];
             
         }
         else
         {

             [Utiles showAlert:ERROR Message:@"Enter valid email address"];
             
             //             [self ForgotPassClicked:self];
             [self.indicatorView stopAnimating];
             _indicatorView.hidden=YES;

             
         }
         
//         [self.indicatorView stopAnimating];

         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [Utiles showAlert:ERROR Message:[error localizedDescription]];
         
     }];
    
}


#pragma mark UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
