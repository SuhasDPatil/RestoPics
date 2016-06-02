//
//  RestaurantListViewController.m
//  MenuPics
//
//  Created by rac on 27/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import "RestaurantListViewController.h"

@interface RestaurantListViewController ()

@end

@implementation RestaurantListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    
    if ([self.btnFind isEqual:@"Find"])
    {
        [self FindRestWebService];
    }
    else if ([self.btnGPS isEqual:@"GPS"])
    {
        [self GPSWebService];
    }

    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.navigationController.navigationBarHidden=NO;

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];

    [self setNavBar];
    self.title=@"Restaurant List";
    
    
    [self.tableView reloadData];
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






#pragma mark TableViewDelegate and Datasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return RestaurantListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RestaurantViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[RestaurantViewCell alloc]init];
    tempCell.cellDict=[RestaurantListArray objectAtIndex:indexPath.row];
    
    
    cell.lblRestaurantName.text=tempCell.cellDict[@"RestaurantName"];
    cell.lblResturantAddress.text=[NSString stringWithFormat:@"%@ %@",tempCell.cellDict[@"RestaurantAddress"],tempCell.cellDict[@"RestaurantCity"]];
    cell.lblRestaurantPhone.text=tempCell.cellDict[@"RestaurantPhone1"];
    
    cell.lblFavCount.text=tempCell.cellDict[@"RestaurantLikeCount"];
    NSString * diealC=tempCell.cellDict[@"DealCount"];
    
    if ([diealC isEqualToString:@"0"]) {
        cell.lblDealCount.textColor=[UIColor lightGrayColor];
        cell.lblDealCount.text=diealC;
        cell.imgDeals.image=[UIImage imageNamed:@"deal_gray.png"];
        cell.btnDeals.hidden=YES;
        
    }
    else
    {
        cell.lblDealCount.textColor=[UIColor colorWithRed:10.f/255 green:180.0f/255 blue:60.0f/255 alpha:1.0];
        cell.lblDealCount.text=diealC;
        cell.imgDeals.image=[UIImage imageNamed:@"deal_green.png"];
        cell.btnDeals.hidden=NO;

    }
    

    
    cell.btnDeals.tag=indexPath.row;
    
    [cell.btnDeals addTarget:self action:@selector(dealButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}


-(void)dealButtonClicked:(UIButton*)sender
{
    if (sender.tag == 0)
    {
        
        NSLog(@"Tag is ZERO");
    }
    else
    {
//        RestaurantDealsViewController * dlvc=[[RestaurantDealsViewController alloc]init];
//        
//        
//        dlvc.restaurantsID=_RestaurantPin;
//        dlvc.btnDeal=@"Deal";
//    
//        NSLog(@"Seder tag=== %li",(long)sender.tag);
//        
//
//        [self.navigationController pushViewController:dlvc animated:YES];
        
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuListingViewController *mlvc = [[MenuListingViewController alloc] initWithNibName:@"MenuListingViewController" bundle:nil];
    
    tempCell.cellDict=[RestaurantListArray objectAtIndex:indexPath.row];
    
    mlvc.FKRestaurantPin=tempCell.cellDict[@"RestaurantPin"];
    mlvc.RestaurantName=tempCell.cellDict[@"RestaurantName"];
    mlvc.RestaurantAddress=tempCell.cellDict[@"RestaurantAddress"];
    mlvc.RestaurantCity=tempCell.cellDict[@"RestaurantCity"];
    mlvc.RestaurantPhone1=tempCell.cellDict[@"RestaurantPhone1"];
    
    [self.navigationController pushViewController:mlvc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116.0f;
}


#pragma mark Webservices

-(void)FindRestWebService
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:self.S_text forKey:@"SearchText"];
    
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_REST_BY_SEARCH
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         [self.indicatorView startAnimating];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             RestaurantListArray=[[NSMutableArray alloc]init];
             RestaurantListArray=[responseObject objectForKey:@"Data"];
             if(RestaurantListArray.count>0)
             {
                 int i;
                 for (i=0; i<RestaurantListArray.count; i++)
                 {
                     NSDictionary * d = [RestaurantListArray objectAtIndex:i];
                     
                     _RestaurantName=[d valueForKey:@"RestaurantName"];
                     _RestaurantAddress=[d valueForKey:@"RestaurantAddress"];
                     _RestaurantCity=[d valueForKey:@"RestaurantCity"];
                     _RestaurantCountry=[d valueForKey:@"RestaurantCountry"];
                     _RestaurantDesc=[d valueForKey:@"RestaurantDesc"];
                     _RestaurantEmail=[d valueForKey:@"RestaurantEmail"];
                     _RestaurantID=[d valueForKey:@"RestaurantID"];
                     _RestaurantPhone1=[d valueForKey:@"RestaurantPhone1"];
                     _RestaurantPin=[d valueForKey:@"RestaurantPin"];
                     _RestaurantZipcode=[d valueForKey:@"RestaurantZipcode"];
                     _RestaurantPhoto=[d valueForKey:@"RestaurantPhoto"];
                     _RestaurantLikeCount=[d valueForKey:@"RestaurantLikeCount"];
                     _DealCount=[d valueForKey:@"DealCount"];
                     _Restaurant_Like=[d valueForKey:@"Restaurant_Like"];
                     _Restaurant_Dislike=[d valueForKey:@"Restaurant_Dislike"];
                     
                 }
             }
             else
             {

             }
         }
         else
         {
             SCLAlertView *alert = [[SCLAlertView alloc] init];
             
             [alert addButton:@"Ok" actionBlock:^(void) {
                 
                 [self.navigationController popViewControllerAnimated:YES];
                 
             }];
             
             [alert showTitle:self title:APP_NAME subTitle:[responseObject objectForKey:@"Message"] style:Warning closeButtonTitle:nil duration:0.0f];
             
         }

         [self.indicatorView stopAnimating];

         [self.tableView reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         self.alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         self.alt1.tag=333;
         [[UIView appearance] setTintColor:[UIColor darkTextColor]];
         [self.alt1 show];
     }];
}

-(void)GPSWebService
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:self.S_Lat forKey:@"Lat"];
    [dict setObject:self.S_Long forKey:@"Long"];
    
    NSLog(@"%@",dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_GET_MENU_BY_GPS
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.indicatorView startAnimating];
         
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             // NSArray *list=[responseObject objectForKey:@"Data"];
             RestaurantListArray=[[NSMutableArray alloc]init];
             RestaurantListArray=[responseObject objectForKey:@"Data"];
             if(RestaurantListArray.count>0)
             {
                 int i;
                 for (i=0; i<RestaurantListArray.count; i++)
                 {
                     NSDictionary * d = [RestaurantListArray objectAtIndex:i];
                     
                     _RestaurantName=[d valueForKey:@"RestaurantName"];
                     _RestaurantAddress=[d valueForKey:@"RestaurantAddress"];
                     _RestaurantCity=[d valueForKey:@"RestaurantCity"];
                     _RestaurantCountry=[d valueForKey:@"RestaurantCountry"];
                     _RestaurantDesc=[d valueForKey:@"RestaurantDesc"];
                     _RestaurantEmail=[d valueForKey:@"RestaurantEmail"];
                     _RestaurantID=[d valueForKey:@"RestaurantID"];
                     _RestaurantPhone1=[d valueForKey:@"RestaurantPhone1"];
                     _RestaurantPin=[d valueForKey:@"RestaurantPin"];
                     _RestaurantZipcode=[d valueForKey:@"RestaurantZipcode"];
                     _RestaurantPhoto=[d valueForKey:@"RestaurantPhoto"];
                     
                     _DealCount=[d valueForKey:@"DealCount"];
                     _Restaurant_Like=[d valueForKey:@"Restaurant_Like"];
                     _Restaurant_Dislike=[d valueForKey:@"Restaurant_Dislike"];
                     
                 }
                 
             }
             else
             {
             }
         }
         else
         {
             SCLAlertView *alert = [[SCLAlertView alloc] init];
             
             [alert addButton:@"Ok" actionBlock:^(void) {
                 
                 [self.navigationController popViewControllerAnimated:YES];
                 
             }];
             
             [alert showTitle:self title:APP_NAME subTitle:[responseObject objectForKey:@"Message"] style:Warning closeButtonTitle:nil duration:0.0f];

         }
         
         [self.indicatorView stopAnimating];
         
         [self.tableView reloadData];
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         self.alt1=[[UIAlertView alloc]initWithTitle:APP_NAME message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         self.alt1.tag=333;
         [[UIView appearance] setTintColor:[UIColor darkTextColor]];
         
         [self.alt1 show];
     }];
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
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark User Defined
-(void)setNavBar
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15],NSFontAttributeName, nil]];
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 16, 10);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
