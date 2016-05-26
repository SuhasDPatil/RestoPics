//
//  DealsListViewController.m
//  MenuPics
//
//  Created by rac on 26/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import "DealsListViewController.h"

@interface DealsListViewController ()

@end

@implementation DealsListViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title=@"Deals";

    
//    [self DealsRestaurantWebService];
    
    queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    DealListArray=[[NSMutableArray alloc]init];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial Rounded MT Bold" size:14],NSFontAttributeName, nil]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DealsViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    


}

-(void)viewWillAppear:(BOOL)animated
{
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];

    [self setNavBar];
    
    [self DealsRestaurantWebService];
    

    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark TableView Delegate and Datasource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DealListArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealsViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    tempCell=[[DealsViewCell alloc]init];

    tempCell.cellDict=[DealListArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.lblDealName.text = tempCell.cellDict[@"dealName"];
    cell.lblRestaurantName.text=tempCell.cellDict[@"RestaurantName"];
    cell.lblRestAddress.text=[NSString stringWithFormat:@"%@ %@",tempCell.cellDict[@"RestaurantAddress"],tempCell.cellDict[@"RestaurantAddress"]];
    
    
    NSLog(@"%@",tempCell.cellDict[@"dealName"]);
    
    
    dispatch_async(queue, ^(){
        
        [cell.indicatorV startAnimating];
        
        NSString * imgURL = tempCell.cellDict[@"DealPhoto"];
        
        NSString *replacedStr = [NSString stringWithFormat:@"%@%@", API_DISH_PHOTO,imgURL];
        
        NSString * reps=[replacedStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
        
        NSString * combined=[reps stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        
        NSLog(@"DISH image URL==%@",combined);
        NSURL * url = [NSURL URLWithString:combined];
        NSData * imgData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imgData];
        dispatch_async( dispatch_get_main_queue() , ^(){
            
            cell.imgDealPhoto.image=image;
            
            [cell.indicatorV stopAnimating];
        });
    });

    return cell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DealDetailsViewController *ddvc = [[DealDetailsViewController alloc] initWithNibName:@"DealDetailsViewController" bundle:nil];
    
    tempCell.cellDict=[DealListArray objectAtIndex:indexPath.row];
    
    ddvc.RestaurantName=tempCell.cellDict[@"RestaurantName"];
    ddvc.RestaurantAddress=tempCell.cellDict[@"RestaurantAddress"];
    ddvc.RestaurantCity=tempCell.cellDict[@"RestaurantCity"];
    ddvc.RestaurantPhone1=tempCell.cellDict[@"RestaurantPhone1"];
    ddvc.RestaurantCountry=tempCell.cellDict[@"RestaurantCountry"];
    ddvc.RestaurantPin=tempCell.cellDict[@"RestaurantPin"];

    
    ddvc.dealName=tempCell.cellDict[@"dealName"];
    ddvc.DealID=tempCell.cellDict[@"DealID"];
    ddvc.dealCondition=tempCell.cellDict[@"dealCondition"];
    ddvc.DealPhoto=tempCell.cellDict[@"DealPhoto"];
    ddvc.StartDate=tempCell.cellDict[@"StartDate"];
    ddvc.StartTime=tempCell.cellDict[@"StartTime"];
    ddvc.EndDate=tempCell.cellDict[@"EndDate"];
    ddvc.endTime=tempCell.cellDict[@"endTime"];

    NSLog(@"Selected Restaurant Name==%@",ddvc.RestaurantName);
    
    [self.navigationController pushViewController:ddvc animated:YES];

    
}


#pragma mark Webservice

-(void)DealsRestaurantWebService
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    
    
    NSString * lati=[defaults valueForKey:@"Lat"];
    NSString * longi=[defaults valueForKey:@"Long"];
    
    if (lati==nil)
    {
        lati=@"0";
    }
    else
    {
        lati=[defaults valueForKey:@"Lat"];
    }
    
    if (longi==nil)
    {
        longi=@"0";
    }
    else
    {
        longi=[defaults valueForKey:@"Long"];
    }
    
    
    [dict setObject:lati forKey:@"Lat"];
    [dict setObject:longi forKey:@"Long"];
    
//    [dict setObject:@"18.49" forKey:@"Lat"];
//    [dict setObject:@"73.94" forKey:@"Long"];

    
    NSLog(@"%@",dict);
    
    [[AFAppAPIClient WSsharedClient] POST:API_RESTAURANT_DEAL_GPS
                               parameters:dict
                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [_indicatorView startAnimating];
         BOOL result=[[responseObject objectForKey:@"Result"] boolValue];
         
         if(result)
         {
             NSLog(@"Data:%@",[responseObject objectForKey:@"Data"]);
             DealListArray=[[NSMutableArray alloc]init];
             DealListArray=[responseObject objectForKey:@"Data"];
             if(DealListArray.count>0)
             {
                 NSLog(@"Deal Array Count:::%ld",(unsigned long)DealListArray.count);
                 int i;
                 for (i=0; i<DealListArray.count; i++)
                 {
                     NSDictionary * d = [DealListArray objectAtIndex:i];
                     
                     _DealID=[d valueForKey:@"DealID"];
                     _DealPhoto=[d valueForKey:@"DealPhoto"];
                     _EndDate=[d valueForKey:@"EndDate"];
                     _StartDate=[d valueForKey:@"StartDate"];
                     _StartTime=[d valueForKey:@"StartTime"];
                     _dealCondition=[d valueForKey:@"dealCondition"];
                     _dealName=[d valueForKey:@"dealName"];
                     _endTime=[d valueForKey:@"endTime"];
                     
                     _RestaurantActivateViaEmail=[d valueForKey:@"RestaurantActivateViaEmail"];
                     _RestaurantAddress=[d valueForKey:@"RestaurantAddress"];
                     _RestaurantCity=[d valueForKey:@"RestaurantCity"];
                     _RestaurantCountry=[d valueForKey:@"RestaurantCountry"];
                     _RestaurantDesc=[d valueForKey:@"RestaurantDesc"];
                     _RestaurantEmail=[d valueForKey:@"RestaurantEmail"];
                     _RestaurantHastag=[d valueForKey:@"RestaurantHastag"];
                     _RestaurantID=[d valueForKey:@"RestaurantID"];
                     _RestaurantManagerEmail=[d valueForKey:@"RestaurantManagerEmail"];
                     _RestaurantManagerName=[d valueForKey:@"RestaurantManagerName"];
                     _RestaurantManagerPhone=[d valueForKey:@"RestaurantManagerPhone"];
                     _RestaurantName=[d valueForKey:@"RestaurantName"];
                     _RestaurantPhone1=[d valueForKey:@"RestaurantPhone1"];
                     _RestaurantPhone2=[d valueForKey:@"RestaurantPhone2"];
                     _RestaurantPin=[d valueForKey:@"RestaurantPin"];
                     _RestaurantPhoto=[d valueForKey:@"RestaurantPhoto"];
                     _RestaurantState=[d valueForKey:@"RestaurantState"];
                     _RestaurantZipcode=[d valueForKey:@"RestaurantZipcode"];
                     
                     NSLog(@"Rest Name: %@", _RestaurantName);
                     NSLog(@"Deal Name: %@", _dealName);
                     NSLog(@"Deal Photo: %@", _DealPhoto);
                 }
             }
             else
             {
                 
             }
         }
         else
         {
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:APP_NAME message:[responseObject objectForKey:@"Message"] preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action)
                                        {
                                            [self.tabBarController setSelectedIndex:0];
                                        }];
             [alertController addAction:okAction];
             
             [self presentViewController:alertController animated:YES completion:nil];
         }

         [_indicatorView stopAnimating];
         
         [self.tableView reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
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
            [self.tabBarController setSelectedIndex:0];
        }
    }
    else if (self.alt1.tag==222)
    {
        if (buttonIndex==0)
        {
            [self.tabBarController setSelectedIndex:0];
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
    
}



@end
