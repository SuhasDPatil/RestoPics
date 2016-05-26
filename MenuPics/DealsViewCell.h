//
//  DealsViewCell.h
//  MenuPics
//
//  Created by rac on 03/09/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblRestaurantName;

@property (strong, nonatomic) IBOutlet UILabel *lblDealName;

@property (strong, nonatomic) IBOutlet UIImageView *imgDealPhoto;



@property (strong, nonatomic) IBOutlet UILabel *lblRestAddress;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorV;





@property(nonatomic,retain)NSMutableDictionary *cellDict;

@end
