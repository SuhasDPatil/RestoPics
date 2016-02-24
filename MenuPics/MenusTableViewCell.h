//
//  MenusTableViewCell.h
//  MenuPics
//
//  Created by rac on 28/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenusTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblDishName;

@property (strong, nonatomic) IBOutlet UILabel *lblDishCalories;

@property (strong, nonatomic) IBOutlet UILabel *lblDishPrice;

@property (strong, nonatomic) IBOutlet UIImageView *imgDishImage;

@property (strong, nonatomic) IBOutlet UILabel *lblPriceBG;


@property (strong, nonatomic) IBOutlet UIImageView *imgPriceBG;


@property(nonatomic,retain)NSMutableDictionary *cellDict;



@end
