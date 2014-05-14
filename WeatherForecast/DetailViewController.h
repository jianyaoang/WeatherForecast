//
//  DetailViewController.h
//  WeatherForecast
//
//  Created by Jian Yao Ang on 5/13/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitiesWeatherInformation.h"
#import "City.h"
@interface DetailViewController : UIViewController
@property CitiesWeatherInformation *citiesWeatherInformation;
@property City *city;
@property NSMutableArray *citiesData;
@property NSMutableArray *cityForecast;
@end
