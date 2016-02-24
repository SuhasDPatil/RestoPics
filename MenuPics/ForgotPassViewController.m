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
    
    [self SlideDownScreen];
    
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
    
    [self SlideDownScreen];
    
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
    [self SlideupScreen:textField];
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self SlideDownScreen];
    
    [textField resignFirstResponder];
    
    return YES;
}



#pragma mark User Defined Methods
//
//-(void)setKeyboard
//{
//    
//    UIToolbar* keyboardToolBar = [[UIToolbar alloc] init];
//    //   [keyboardToolBar setBackgroundImage:[UIImage imageNamed:@"SerchbarBackground.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
//    
//    keyboardToolBar.barStyle = UIBarStyleBlack;
//    keyboardToolBar.backgroundColor=[UIColor darkGrayColor];
//    keyboardToolBar.translucent = YES;
//    keyboardToolBar.alpha=0.8f;
//    // for ios 6
//    keyboardToolBar.tintColor = [UIColor whiteColor];
//    // for ios 7
//    //keyboardToolBar.tintColor = [UIColor whiteColor];
//    
//    [keyboardToolBar sizeToFit];
//    
//    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                   style:UIBarButtonItemStylePlain target:self
//                                                                  action:@selector(doneButtonClicked:)];
//    
//    
//    
//    [keyboardToolBar setItems:[NSArray arrayWithObjects:doneButton,flexibleSpaceLeft, nil]];
//    
//    _txtEmailAddress.inputAccessoryView=keyboardToolBar;
//    
//    
//}
//
//-(void)doneButtonClicked:(id)sender
//{
//    [_txtEmailAddress resignFirstResponder];
//    [self SlideDownScreen];
//    
//    
//    // for ios 6
//    
//    // for ios 7
//    // CGPoint scrollPoint = CGPointMake(0, self.view.frame.origin.y-65);
//    // [scrollView setContentOffset:scrollPoint animated:YES];
//}
//
//
//

-(void)SlideupScreen:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    if ([[UIScreen mainScreen] bounds].size.height ==480)
    {
        
        if ([_txtEmailAddress isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -85,320, self.view.frame.size.height)];
            
        }
    }
    
    else
    {
        if ([_txtEmailAddress isEqual:textField])
        {
            [self.view setFrame:CGRectMake(0, -80,320, self.view.frame.size.height)];
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



#pragma mark WebServices


-(void)ForgotPassWebService
{
    
    
    
    [_txtEmailAddress resignFirstResponder];
    
    NSString * emailID=_txtEmailAddress.text;
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:emailID forKey:@"Username"];
    
    [self.indicatorView startAnimating];

    
    NSLog(@"%@",dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_FORGOT_PASS
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         NSDictionary *dict_res=(NSDictionary *)responseObject;
         
         NSNumber * isSuccessNumber = (NSNumber *)[dict_res objectForKey: RESULT];
         NSLog(@"Result :  %@",isSuccessNumber);
         if([isSuccessNumber boolValue] == YES)
         {
             
             [Utiles showAlert:APP_NAME Message:@"UserName and Password sent successfully on your mail..\n Thank you!!!"];
             
             
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



@end
