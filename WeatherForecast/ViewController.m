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

    allCitiesData = [NSMutableArray new];
    citiesForecastData = [NSMutableArray new];
    
    [self extractingCitiesJSONData];
}

-(void)extractingCitiesJSONData
{
    [self extractingChicagoJSONData];
    [self extractingDallasJSONData];
    [self extractingNewYorkJSONData];
    [self extractingSeattleJSONData];
    [self extractingWashingtonDCJSONData];
    [self extractingCincinnatiJSONData];
    [self extractingSanJoseJSONData];
    [self extractingCupertinoJSONData];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
            }
            [citiesTableView reloadData];
        }
    }];
}

-(void)extractingNewYorkJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/NY/New_York.json"];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
            }
            [citiesTableView reloadData];

        }
    }];
}

-(void)extractingSeattleJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/WA/Seattle.json"];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
            }
            [citiesTableView reloadData];
        }
    }];
}

-(void)extractingWashingtonDCJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/DC/Washington.json"];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
            }
            [citiesTableView reloadData];
        }
    }];
}

-(void)extractingCincinnatiJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/OH/Cincinnati.json"];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
            }
            [citiesTableView reloadData];
        }
    }];
}

-(void)extractingSanJoseJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/CA/San_Jose.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (connectionError)
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to retrieve data" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
            }
            [citiesTableView reloadData];
        }
    }];
}

-(void)extractingCupertinoJSONData
{
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/CA/Cupertino.json"];
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
            
            CitiesWeatherInformation *cwi = [CitiesWeatherInformation new];
            cwi.forecast = [[NSMutableArray alloc] initWithCapacity:10];
            cwi.temp_string = current_observation[@"temperature_string"];
            cwi.temp_c = [current_observation[@"temp_c"]floatValue];
            cwi.temp_f = [current_observation[@"temp_f"]floatValue];
            cwi.city = display_location[@"city"];
            [allCitiesData addObject:cwi];
            
            [cwi.forecast removeAllObjects];
            
            for (NSDictionary *forecastdayInfo in forecastday)
            {
                City *city = [City new];
                city.title = forecastdayInfo[@"title"];
                city.icon = forecastdayInfo[@"icon"];
                city.period = [forecastdayInfo[@"period"]floatValue];
                city.fcttext = forecastdayInfo[@"fcttext"];
                city.fcttext_metric = forecastdayInfo[@"fcttext_metric"];
                [cwi.forecast addObject:city];
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

        DetailViewController *dvc = segue.destinationViewController;
        dvc.citiesWeatherInformation = cwi;
        dvc.navigationItem.title = cwi.city;
    }
}

@end
