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
    NSMutableArray *citiesData;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    current_observation = [NSDictionary new];
    citiesData = [NSMutableArray new];
    [self extractingJSONData];
}

-(void)extractingJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/IL/Chicago.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *citiesWeatherFirstLayer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        current_observation = citiesWeatherFirstLayer[@"current_observation"];
        
        [self assigningWeatherData];
        [citiesTableView reloadData];
    }];
}

-(void)assigningWeatherData
{
    CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
    cwi.temp_string = current_observation[@"temperature_string"];
    cwi.temp_c = [current_observation[@"temp_c"]floatValue];
    cwi.temp_f = [current_observation[@"temp_f"]floatValue];
    [citiesData addObject:cwi];
    NSLog(@"%@", citiesData);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return citiesData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesWeatherInformation *cwi = citiesData[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CitiesWeatherCellID"];
    cell.textLabel.text = @"Hello";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Current temperature: %@",cwi.temp_string];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetailViewController"])
    {
//        NSIndexPath *indexPath = [citiesTableView indexPathForCell:sender];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.navigationItem.title = @"Detail View";
    }
}

@end
