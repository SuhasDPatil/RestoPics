//
//  MenuListingViewController.m
//  MenuPics
//
//  Created by rac on 28/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import "MenuListingViewController.h"

@interface MenuListingViewController ()

@end

@implementation MenuListingViewController
@synthesize filteredMenuArray=_filteredMenuArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication]delegate];
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * userid=[defaults objectForKey:@"UserID"];
    
    if ([userid isEqual:@"0"])
    {
    }
    else
    {
        [self GetRestaurantLikeWebService];
    }
    
    [self MenuListService];

    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    
    self.title=self.RestaurantName;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenusTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"MenusTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationController.navigationBarHidden=NO;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;

}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden=YES;
//}

-(void)viewWillAppear:(BOOL)animated
{
    [self setNavBar];
    //   [self MenuListService];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];

    
    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"DishName contains[c] %@", searchText];
    
    searchMenuArray = [MenuListArray filteredArrayUsingPredicate:resultPredicate];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}



#pragma mark Collection view methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchMenuArray count];
        
    } else {
        return [MenuListArray count];
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenusTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[MenusTableViewCell alloc]init];
    
    
  
    
//    tempCell.cellDict=[MenuListArray objectAtIndex:indexPath.row];

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        tempCell.cellDict = [searchMenuArray objectAtIndex:indexPath.row];
    } else {
        tempCell.cellDict = [MenuListArray objectAtIndex:indexPath.row];
    }
    
    
    // Configure the cell...
    [[cell layer]setBorderWidth:1.2f];
    [[cell layer]setBorderColor:[UIColor clearColor].CGColor];
    [[cell layer]setCornerRadius:3.5f];
    
    [[cell.lblPriceBG layer] setBorderWidth:15.0];
    [[cell.lblPriceBG layer] setBorderColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:40.0f/255 alpha:0.75].CGColor];
    [[cell.lblPriceBG layer]setCornerRadius:15.0f];
    
    
    
    cell.lblDishName.text = tempCell.cellDict[@"DishName"];
    
    NSString * strPrice=tempCell.cellDict[@"DishPrice"];
    NSString * strP=@"$ ";
    
    cell.lblDishPrice.text=[NSString stringWithFormat:@"%@%@",strP,strPrice];
    
    NSString *strCalories=tempCell.cellDict[@"DishCals"];
    NSString *strC=@" Calories";
    
    
    
    // changes by vivek //
    
    if ([strCalories isEqualToString:@"0"])
    {
        
        cell.lblDishCalories.hidden=YES;
        cell.ImageCalories.hidden=YES;
    }
    else
        
    {
        
    cell.lblDishCalories.text=[NSString stringWithFormat:@"%@%@",strCalories,strC];
        
    }
    
    
    NSString * imgURL = tempCell.cellDict[@"DishUrl"];

    NSString *replacedStr = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];

    NSString * reps=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];

    NSString * combined=[reps stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    cell.imgDishImage.image = [UIImage imageNamed:@"placeholder"];
    
    [self.operationManager GET: combined
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           cell.imgDishImage.image = responseObject;
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           NSLog(@"Failed with error %@.", error);
                       }];

    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 202.f;
    }
    else
        return 202.f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MenuDetailsViewController *detMenu = [[MenuDetailsViewController alloc] initWithNibName:@"MenuDetailsViewController" bundle:nil];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        tempCell.cellDict = [searchMenuArray objectAtIndex:indexPath.row];
    } else {
        tempCell.cellDict = [MenuListArray objectAtIndex:indexPath.row];
    }

    
    detMenu.M_UserID=tempCell.cellDict[@"UserID"];
    detMenu.M_DishID=tempCell.cellDict[@"DishID"];
    detMenu.M_DishName=tempCell.cellDict[@"DishName"];
    detMenu.M_DishPhoto=tempCell.cellDict[@"DishUrl"];
    detMenu.M_DishPrice=tempCell.cellDict[@"DishPrice"];
    detMenu.M_DishCals=tempCell.cellDict[@"DishCals"];
    detMenu.M_dislike=tempCell.cellDict[@"dislike"];
    detMenu.M_goodLike=tempCell.cellDict[@"goodLike"];
    detMenu.M_Dishdesc=tempCell.cellDict[@"Dishdesc"];
    detMenu.M_RestaurantName=self.RestaurantName;
    
    
    
    
    [self.navigationController pushViewController:detMenu animated:YES];
    
    
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


#pragma mark Webservices

-(void)MenuListService
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:self.FKRestaurantPin forKey:@"FKRestaurantpin"];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [dict setObject:[defaults objectForKey:@"UserID"] forKey:@"UserID"];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_MENU_BY_REST_ID
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         [self.indicatorView startAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             // NSArray *list=[responseObject objectForKey:@"Data"];
             MenuListArray=[[NSMutableArray alloc]init];
             MenuListArray=[responseObject objectForKey:@"Data"];
             if(MenuListArray.count>0)
             {
                 NSLog(@"Menu Array Count:::%ld",(unsigned long)MenuListArray.count);
                 int i;
                 for (i=0; i<MenuListArray.count; i++)
                 {
                     NSDictionary * d = [MenuListArray objectAtIndex:i];
                     _DishCals=[d valueForKey:@"DishCals"];
                     _DishID=[d valueForKey:@"DishID"];
                     _DishName=[d valueForKey:@"DishName"];
                     _DishPhoto=[d valueForKey:@"DishPhoto"];
                     _DishPrice=[d valueForKey:@"DishPrice"];
                     _Dishdesc=[d valueForKey:@"Dishdesc"];
                     _EnableDisLike=[d valueForKey:@"EnableDisLike"];
                     _EnableLike=[d valueForKey:@"EnableLike"];
                     _Task=[d valueForKey:@"Task"];
                     _UserID=[d valueForKey:@"UserID"];
                     _dislike=[d valueForKey:@"dislike"];
                     _goodLike=[d valueForKey:@"goodLike"];
                     
                 }
             }
             else
             {
                 
             }
         }
         else
         {
             
             // changes by Vivek
             
             SCLAlertView *alert = [[SCLAlertView alloc] init];
             
             [alert addButton:@"Ok" actionBlock:^(void) {
                 
                 [self.navigationController popViewControllerAnimated:YES];
                 
             }];
             
             [alert showTitle:self title:APP_NAME subTitle:[responseObject objectForKey:@"Message"] style:Warning closeButtonTitle:nil duration:0.0f];
         }
         [self.indicatorView stopAnimating];
         
         NSString * str=[defaults objectForKey:@"UserID"];
         
         [self.tableView reloadData];
             
            
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         
         UIAlertView * altv=[[UIAlertView alloc]initWithTitle:self.RestaurantName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         altv.tag=333;
         [altv show];
     }];
    
}



-(void)DoneButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)GetRestaurantLikeWebService
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:self.FKRestaurantPin forKey:@"RestaurantPin"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [dict setObject:[defaults objectForKey:@"UserID"] forKey:@"UserID"];
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_RESTAURANT_LIKE
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         [self.indicatorView startAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         GetLikesArray=[[NSMutableArray alloc]init];
         GetLikesArray=[responseObject objectForKey:DATA];
         NSDictionary * d = [GetLikesArray objectAtIndex:0];
         _RDisLike=[d valueForKey:@"RDisLike"];
         _RLike=[d valueForKey:@"RLike"];
         
         NSString * strD=_RDisLike;
         NSNumber * strL=_RLike;
         
         if(result)
         {
             
             _RDisLike=[d valueForKey:@"RDisLike"];
             _RLike=[d valueForKey:@"RLike"];
             if ([strD isEqual:[NSNumber numberWithLong:1]])
             {
                 [_btnFavourite setBackgroundImage:[UIImage imageNamed:@"favourites_gray.png"] forState:UIControlStateNormal];
             }
             else
             {
                 [_btnFavourite setBackgroundImage:[UIImage imageNamed:@"favourites_orange.png"] forState:UIControlStateNormal];
             }
             
         }
         else
         {
             _RDisLike=[d valueForKey:@"RDisLike"];
             _RLike=[d valueForKey:@"RLike"];
             
         }

         [self.indicatorView stopAnimating];
         
         [self.tableView reloadData];
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         UIAlertView * altv=[[UIAlertView alloc]initWithTitle:self.RestaurantName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         [altv show];
     }];
}

-(void)SetRestaurantLikeWebService          //Like Restaurant   Task=1
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:self.FKRestaurantPin forKey:@"RestaurantID"];
    [dict setObject:@"1" forKey:@"Task"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [dict setObject:[defaults objectForKey:@"UserID"] forKey:@"UserID"];
    
    [[AFAppAPIClient WSsharedClient] POST:API_SAVE_REST_LIKE_DISLIKE
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         [self.indicatorView startAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             NSArray * array=[[NSArray alloc]init];
             array=[responseObject objectForKey:DATA];
             
             
             //             _btnFavourite.backgroundColor=[UIColor yellowColor];
             
             
             [_btnFavourite setBackgroundImage:[UIImage imageNamed:@"favourites_orange.png"] forState:UIControlStateNormal];
             
             
             
         }

         [self.indicatorView stopAnimating];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error){
         
         UIAlertView * altv=[[UIAlertView alloc]initWithTitle:self.RestaurantName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         [altv show];
         
     }];
}

-(void)SetRestaurantDislikeWebService       //Dislike Restaurant     Task=2
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:self.FKRestaurantPin forKey:@"RestaurantID"];
    [dict setObject:@"2" forKey:@"Task"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [dict setObject:[defaults objectForKey:@"UserID"] forKey:@"UserID"];
    [[AFAppAPIClient WSsharedClient] POST:API_SAVE_REST_LIKE_DISLIKE
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         [self.indicatorView startAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         if(result)
         {
             NSArray * array=[[NSArray alloc]init];
             array=[responseObject objectForKey:DATA];
             
             //             _btnFavourite.backgroundColor=[UIColor redColor];
             
             [_btnFavourite setBackgroundImage:[UIImage imageNamed:@"favourites_gray.png"] forState:UIControlStateNormal];
             
             
         }

         [self.indicatorView stopAnimating];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error){
         
         UIAlertView * altv=[[UIAlertView alloc]initWithTitle:self.RestaurantName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         [altv show];
     }];
}

#pragma mark User Defined
-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial Rounded MT Bold" size:14],NSFontAttributeName, nil]];
    
    //Back Button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 16, 10);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    //Address Button
    _btnAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage = [UIImage imageNamed:@"address.png"]  ;
    [_btnAddress setBackgroundImage:rightBtnImage forState:UIControlStateNormal];
    [_btnAddress addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
    _btnAddress.frame = CGRectMake(0, 0, 21, 18);
    UIBarButtonItem *Address = [[UIBarButtonItem alloc] initWithCustomView:_btnAddress] ;
    
    //Call Button
    _btnCall= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage2 = [UIImage imageNamed:@"call.png"]  ;
    [_btnCall setBackgroundImage:rightBtnImage2 forState:UIControlStateNormal];
    [_btnCall addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    _btnCall.frame = CGRectMake(0, 0, 21, 18);
    UIBarButtonItem *Call= [[UIBarButtonItem alloc] initWithCustomView:_btnCall] ;
    
    //Favorite Button
    _btnFavourite = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage3 = [UIImage imageNamed:@"favourites_gray.png"]  ;
    [_btnFavourite setBackgroundImage:rightBtnImage3 forState:UIControlStateNormal];
    [_btnFavourite addTarget:self action:@selector(favAction) forControlEvents:UIControlEventTouchUpInside];
    _btnFavourite.frame = CGRectMake(0, 0, 21, 18);
    //    _btnFavourite.backgroundColor=[UIColor redColor];
    UIBarButtonItem *Favorite = [[UIBarButtonItem alloc] initWithCustomView:_btnFavourite] ;
    
    self.navigationItem.rightBarButtonItems=[[NSArray alloc]initWithObjects:Address,Call, nil];
}
#pragma mark Navigation Bar button Actions
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)favAction
{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * str=[defaults objectForKey:@"UserID"];
    
    if ([str isEqual:@"0"])
    {
        [_btnFavourite setBackgroundImage:[UIImage imageNamed:@"favourites_gray.png"] forState:UIControlStateNormal];
        
        LoginViewController * log=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];

    }
    else
    {
        if ([[_btnFavourite backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"favourites_gray.png"]])
        {
            [self SetRestaurantLikeWebService];
        }
        else
        {
            [self SetRestaurantDislikeWebService];
        }
    }
}


-(void)callAction
{
    NSString *phNo = self.RestaurantPhone1;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        UIAlertView * calert = [[UIAlertView alloc]initWithTitle:APP_NAME message:@"\nCall facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [[UIView appearance] setTintColor:[UIColor darkTextColor]];
        [calert show];
    }
}

-(void)addressAction
{
    UIAlertView * altv=[[UIAlertView alloc]initWithTitle:self.RestaurantName message:[NSString stringWithFormat:@"\n%@,\n%@.",self.RestaurantAddress,self.RestaurantCity] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [[UIView appearance] setTintColor:[UIColor darkTextColor]];
    altv.tag=600;
    [altv show];
}


#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (alertView.tag==222)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (alertView.tag==333)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (alertView.tag==444) //Set Favorite Alert action
    {
        if (buttonIndex==0)
        {
            [_btnFavourite setBackgroundImage:[UIImage imageNamed:@"favourites_gray.png"] forState:UIControlStateNormal];
            
        }
        else if (buttonIndex==1)
        {
            LoginViewController * log=[[LoginViewController alloc]init];
            [self.navigationController pushViewController:log animated:YES];
            
        }
    }
    else if (alertView.tag==555) //view Menu Not avilable
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
    }
}




@end
