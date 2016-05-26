//
//  Constant.h
//  MENUPICS
//
//  Created by Suhas on 23/08/15.
//  Copyright (c) 2015 SandsTechnologies. All rights reserved.
//
#import "Utiles.h"

#define APP_NAME @"MenuPics" 
#define ERROR @"MenuPics Error"
#define RESULT @"Result"
#define DATA @"Data"


//Local IP used only in wifi range
//
//#define API_BASE_URL @"http://192.168.1.9/MenupicsWS/Users.svc/"
//
//#define API_RESTAURANT_PHOTO @"http://192.168.1.9/Menupics"
//#define API_DISH_PHOTO @"http://trymenupics.com"
//#define API_DEAL_DISH_PHOTO @"http://192.168.1.9/Menupics"
//#define API_USER_PHOTO @"http://192.168.1.9"



//
//
////without wifi on network datapack API
//
//#define API_BASE_URL @"http://117.218.164.150/MenupicsWS/Users.svc/"
//
//#define API_RESTAURANT_PHOTO @"http://117.218.164.150/Menupics"
//#define API_DISH_PHOTO @"http://trymenupics.com"
//#define API_DEAL_DISH_PHOTO @"http://117.218.164.150/Menupics"
//#define API_USER_PHOTO @"http://117.218.164.150"
//
//
// from live server

#define API_BASE_URL @"http://rss.trymenupics.com/Users.svc/"

#define API_RESTAURANT_PHOTO @"http://trymenupics.com/Menupics"
#define API_DISH_PHOTO @"http://trymenupics.com"
#define API_DEAL_DISH_PHOTO @"http://trymenupics.com/Menupics"
#define API_USER_PHOTO @"http://rss.trymenupics.com/menupicsws/UserPhotos/"

#define API_user_photo @"http://rss.trymenupics.com"


// Server 202.38.172.176
//
//#define API_BASE_URL @"http://202.38.172.176/MenuPicsWebService/Users.svc/"
//
//#define API_RESTAURANT_PHOTO @"http://202.38.172.176/MenuPicsWebService/RestaurantPhoto/"
//#define API_DISH_PHOTO @"http://202.38.172.176/Menupics"
//#define API_DEAL_DISH_PHOTO @"http:202.38.172.176/Menupics/MenuCreate/DealImages/"
//#define API_USER_PHOTO @"http://202.38.172.176/MenuPicsWebService/UserPhotos/"



//   1.Search Restaurant by Search text        i/p:   "SearchText"
#define API_GET_REST_BY_SEARCH (API_BASE_URL @"RestaurantListby_GPS_SearchText")


//   2.Get Menu List By Restaurant ID          i/p:   "FKRestaurantpin"
#define API_GET_MENU_BY_REST_ID (API_BASE_URL @"RestaurantMenuListby_RestaurantID")


//   3.Get Menu Details by dish ID              i/p:  "DishID"
#define API_GET_DISH_DETAIL_DISH_ID (API_BASE_URL @"SearchDishDetailsBy_DishID")


//   4.Get Menu List By GPS(Lat,Long)           i/p:   "Lat","Long"
#define API_GET_MENU_BY_GPS (API_BASE_URL @"RestaurantListby_GPS")


//   5. End User Login                          i/p:    "EmailID","Password"
#define API_LOGIN (API_BASE_URL @"UserLogin")



//   5a. Forgot Password                          i/p:    "Username"
#define API_FORGOT_PASS (API_BASE_URL @"FetchPassword")



//   6. End User Registration
//        i/p:  "UserID","EmailID","Password","Gender","UserAge","UserPhone","Role","Name","Address","Task"
#define API_REGISTER (API_BASE_URL @"SaveUser")


//   7. Valid User                               i/p:    "Name","UserEmail"
#define API_VALID_USER (API_BASE_URL @"ValidUser")


//   8. Get Favorite Restaurant List             i/p:    "UserID"
#define API_RESTAURANT_FAVORITE_LIST_UID (API_BASE_URL @"RestaurantLikeListby_UID")


//   9. Get restaurant Like in menu listing screen         i/p:    "RestaurantPin","UserID"
#define API_GET_RESTAURANT_LIKE (API_BASE_URL @"GetRestaurantLike")


//   10. Set as Like to Restaurant using "Task"==1         i/p:    "RestaurantPin","UserID"
//   11. Set as Dislike to Restaurant using "Task"==2              "Task"
#define API_SAVE_REST_LIKE_DISLIKE (API_BASE_URL @"SaveRestaurantLikeAndDislike")


//   12. Set as Like to Dish using "Task"==1               i/p:    "DishID","UserID"
//   13. Set as Dislike to Dish using "Task"==2                     "Task"
#define API_SAVE_DISH_LIKE_DISLIKE (API_BASE_URL @"SaveDishLikeDislike")


//   14. Comment on Dish Menu                  i/p:"FkresturantPin","DishID","UserID","Comment"
#define API_SAVE_DISH_COMMENT (API_BASE_URL @"SaveDishComment")


//   15.  Get User Profile                     i/p: "EmailID","Password","Gender","UserAge",
//                                          "UserPhone","Role","Name","Address","Task","UsersPhoto","UserID"
#define API_UPLOAD_USER_PHOTO (API_BASE_URL @"UploadPhotoString")     //NOT used yet
#define API_REMOVE_USER_PHOTO (API_BASE_URL @"RemoveUserPhoto")       //NOT used yet


//   16.  Get Restaurant Deal list by GPS                   i/p:    "Lat","Long"    
#define API_RESTAURANT_DEAL_GPS (API_BASE_URL @"RestaurantDealListby_GPS")


//   16.  Get Restaurant Deal list by GPS                   i/p: "FkresturantPin"
#define API_RESTAURANT_DEAL_BY_REST_ID (API_BASE_URL @"DealsListbyResturantID")


#define Active @"0";


//#define API_RESTAURANT_LIKE_UID (API_BASE_URL @"RestaurantLikeListby_UID")

#define API_RESTAURANT_SEARCH_TXT_PIN (API_BASE_URL @"SearchRestaurantListby_GPS_PinCode")



//#define API_SAVE_REST_LIKE_DISLIKE (API_BASE_URL @"SaveRestaurantLikeAndDislike")

#define API_SAVE_DEAL_COMMENT (API_BASE_URL @"SaveDealComment")
#define API_SAVE_DEALS_LIKE_DISLIKE (API_BASE_URL @"SaveDealsLikeAndDislike")

#define API_SEARCH_DEAL_REST_ID (API_BASE_URL @"SearchDealListBy_RestaurantID")
#define API_SEARCH_DEAL_DETAIL_DEAL_ID (API_BASE_URL @"SearchDealDetailsBy_DealID")




#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


