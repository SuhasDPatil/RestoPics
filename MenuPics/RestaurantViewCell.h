//
//  RestaurantViewCell.h
//  MenuPics
//
//  Created by rac on 27/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RestaurantViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantName;

@property (strong, nonatomic) IBOutlet UILabel *lblResturantAddress;

@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantPhone;

@property (strong, nonatomic) IBOutlet UILabel *lblDealCount;

@property (strong, nonatomic) IBOutlet UILabel *lblFavCount;

@property (strong, nonatomic) IBOutlet UIImageView *imgDeals;

@property (strong, nonatomic) IBOutlet UIButton *btnDeals;



@property(nonatomic,retain)NSMutableDictionary *cellDict;




- (IBAction)dealsClicked:(id)sender;


@end
