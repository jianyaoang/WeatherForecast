//
//  CitiesWeatherInformation.h
//  WeatherForecast
//
//  Created by Jian Yao Ang on 5/13/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesWeatherInformation : NSObject

@property (strong, nonatomic) NSString *temp_string;
@property (strong, nonatomic) NSString *icon;
@property float temp_f;
@property float temp_c;
@property (strong, nonatomic) NSString *city;
@property float period;
@property (strong, nonatomic) NSString *title;
@property (strong,nonatomic)  NSString *fcttext;
@property (strong, nonatomic) NSString *fcttext_metric;



@end
