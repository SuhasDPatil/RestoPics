//
//  ForgotPassViewController.h
//  MenuPics
//
//  Created by rac on 24/09/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFAppAPIClient.h"
#import "Constant.h"
#import "ProfileViewController.h"

#import "SCLAlertView.h"
@interface ForgotPassViewController : UIViewController<UIAlertViewDelegate>




@property (strong, nonatomic) IBOutlet UIView *viewBorder;


@property (strong, nonatomic) IBOutlet UIButton *btnSend;

@property (strong, nonatomic) IBOutlet UIButton *btnReturnLogin;

@property (strong, nonatomic) IBOutlet UITextField *txtEmailAddress;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;


- (IBAction)sendClicked:(id)sender;


- (IBAction)returnLoginClicked:(id)sender;

@end
