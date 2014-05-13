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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *citiesTableView;
    NSDictionary *current_observation;
    NSDictionary *display_location;
    NSDictionary *forecast;
    NSMutableArray *citiesData;
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
    citiesData = [NSMutableArray new];
    
    [self extractingJSONData];
}

-(void)extractingJSONData
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
            
            [citiesData removeAllObjects];
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
                cwi.title = forecastdayInfo[@"title"];
                cwi.period = [forecastdayInfo[@"period"]floatValue];
                cwi.fcttext = forecastdayInfo[@"fcttext"];
                cwi.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                cwi.temp_string = current_observation[@"temperature_string"];
                cwi.temp_c = [current_observation[@"temp_c"]floatValue];
                cwi.temp_f = [current_observation[@"temp_f"]floatValue];
                cwi.city = display_location[@"city"];
                [citiesData addObject:cwi];
                NSLog(@"citiesData in Loop: %@",cwi.fcttext);
            }
            
//            [self assigningWeatherData];
            [citiesTableView reloadData];
        }
    }];
}

//-(void)assigningWeatherData
//{
//    CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
//    cwi.temp_string = current_observation[@"temperature_string"];
//    cwi.temp_c = [current_observation[@"temp_c"]floatValue];
//    cwi.temp_f = [current_observation[@"temp_f"]floatValue];
//    cwi.city = display_location[@"city"];
//    [citiesData addObject:cwi];
//    NSLog(@"%@", citiesData);
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return citiesData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesWeatherInformation *cwi = citiesData[indexPath.row];
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
        CitiesWeatherInformation *cwi = [citiesData objectAtIndex:indexPath.row];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.citiesWeatherInformation =cwi;
        dvc.citiesData = citiesData;
        dvc.navigationItem.title = cwi.city;
    }
}

@end
