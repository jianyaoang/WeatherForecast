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
@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    IBOutlet UITableView *citiesTableView;
    IBOutlet UISearchBar *cityZipCodeSearchBar;
    
    NSDictionary *current_observation;
    NSDictionary *display_location;
    NSDictionary *forecast;
    NSMutableArray *allCitiesData;
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
    
    NSDictionary *citiesAndStates = @{@"Chicago": @"IL",@"Dallas":@"TX",@"New_York":@"NY", @"Seattle":@"WA",@"Washington":@"DC", @"Cincinnati":@"OH", @"San_Jose":@"CA", @"Cupertino":@"CA", @"San_Diego":@"CA", @"Las_Vegas":@"NV"};
    
    [self extractingCitiesJSONData:citiesAndStates];
}

-(void)extractingCitiesJSONData:(NSDictionary *) citiesAndStates
{
    for (NSString *key in citiesAndStates)
    {
        [self extractCityByName:key withState:citiesAndStates[key]];
    }
}

-(void)extractCityByName:(NSString *)cityName withState:(NSString *)stateID
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.wunderground.com/api/ac564405ca26fd91/forecast10day/conditions/q/%@/%@.json",stateID, cityName];
    NSURL *url = [NSURL URLWithString:urlString];
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
             cwi.zip = display_location[@"zip"];
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

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    cityZipCodeSearchBar.placeholder = @"";
    cityZipCodeSearchBar.text = @"";
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    cityZipCodeSearchBar.placeholder = @"enter city zip code";
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [cityZipCodeSearchBar resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchWithText:searchText];
}

-(void)searchWithText:(NSString*)searchText
{
    if (searchText.length == 5)
    {
        NSString *urlString = [NSString stringWithFormat:@"http://api.wunderground.com/api/ac564405ca26fd91/geolookup/forecast10day/conditions/q/%@.json", searchText];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             if (connectionError)
             {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Detected" message:@"Please check internet connectivity. Please ensure there are no spaces between characters in search field." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
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
                 cwi.zip = display_location[@"zip"];
                 [allCitiesData addObject:cwi];
                 
                 if (current_observation == nil)
                 {
                     [allCitiesData removeLastObject];
                 }
                 
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
                 if (!(current_observation == nil && display_location == nil))
                 {
                     [citiesTableView reloadData];
                 }
             }
            }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [cityZipCodeSearchBar resignFirstResponder];
    
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
