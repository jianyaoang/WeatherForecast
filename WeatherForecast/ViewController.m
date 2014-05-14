//
//  ViewController.m
//  WeatherForecast
//
//  Created by Jian Yao Ang on 5/13/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "CitiesWeatherInformation.h"
#import "City.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *citiesTableView;
    NSDictionary *current_observation;
    NSDictionary *display_location;
    NSDictionary *forecast;
    NSMutableArray *citiesChicagoData;
    NSMutableArray *citiesDallasData;
    NSMutableArray *allCitiesData;
    NSMutableArray *citiesForecastData;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Cities Weather";
    current_observation = [NSDictionary new];
    display_location = [NSDictionary new];
    forecast = [NSDictionary new];

    citiesChicagoData = [NSMutableArray new];
    citiesDallasData = [NSMutableArray new];
    [self extractingChicagoJSONData];
    [self extractingDallasJSONData];
    
    allCitiesData = [NSMutableArray new];
    citiesForecastData = [NSMutableArray new];
//    allCitiesData = [NSMutableArray arrayWithObjects:citiesChicagoData,citiesSeattleData, nil];
//    NSLog(@"All Cities Data :%@",allCitiesData);
}

-(void)extractingChicagoJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/IL/Chicago.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (connectionError)
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to retrive data" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [av show];
        }
        else
        {
            NSDictionary *citiesWeatherFirstLayer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
            current_observation = citiesWeatherFirstLayer[@"current_observation"];
            display_location = current_observation[@"display_location"];
            
            forecast = citiesWeatherFirstLayer[@"forecast"];
            NSDictionary *txt_forecast = forecast[@"txt_forecast"];
            NSArray *forecastday = txt_forecast[@"forecastday"];
            
            [citiesChicagoData removeAllObjects];
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            City *city = [City new];
            city.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [city.forecast addObject:city];
//                [citiesChicagoData addObject:cwi];
//                [allCitiesData addObject:cwi];
//                NSLog(@"citiesData in Loop: %@",cwi.fcttext);
                NSLog(@"city.forecast 1: %@ %d",city.fcttext, city.forecast.count);
            }
            [citiesTableView reloadData];
        }

    }];
}

-(void)extractingDallasJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/TX/Dallas.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (connectionError)
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to retrieve data" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [av show];
        }
        else
        {
            NSDictionary *citiesWeatherFirstLayer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
            current_observation = citiesWeatherFirstLayer[@"current_observation"];
            display_location = current_observation[@"display_location"];
            
            forecast = citiesWeatherFirstLayer[@"forecast"];
            NSDictionary *txt_forecast = forecast[@"txt_forecast"];
            NSArray *forecastday = txt_forecast[@"forecastday"];
            
            [citiesDallasData removeAllObjects];
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            City *city = [City new];
            city.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [city.forecast addObject:city];
                NSLog(@"city.forecast 2: %d",city.forecast.count);
//                [citiesDallasData addObject:cwi];
//                [allCitiesData addObject:cwi];
            }
            [citiesTableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allCitiesData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesWeatherInformation *cwi = allCitiesData[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CitiesWeatherCellID"];
    cell.textLabel.text = cwi.city;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Current temperature: %@",cwi.temp_string];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetailViewController"])
    {
        NSIndexPath *indexPath = [citiesTableView indexPathForCell:sender];
        CitiesWeatherInformation *cwi = [allCitiesData objectAtIndex:indexPath.row];

//        NSLog(@"%@",city.forecast);
        DetailViewController *dvc = segue.destinationViewController;
        dvc.citiesWeatherInformation = cwi;
        dvc.navigationItem.title = cwi.city;
    }
}

@end
