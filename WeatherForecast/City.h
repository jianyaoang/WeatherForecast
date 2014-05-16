//
//  City.h
//  WeatherForecast
//
//  Created by Jian Yao Ang on 5/14/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property (strong, nonatomic) NSMutableArray *forecast;
@property double period;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *title;
@property (strong,nonatomic)  NSString *fcttext;
@property (strong, nonatomic) NSString *fcttext_metric;

@end
