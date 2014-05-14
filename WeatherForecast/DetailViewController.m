//
//  DetailViewController.m
//  WeatherForecast
//
//  Created by Jian Yao Ang on 5/13/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
{

}

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.citiesData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesWeatherInformation *cwi = self.citiesData[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherForecastCellID"];
    cell.textLabel.text = cwi.fcttext;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Day:%@ Status:%@ ",cwi.title, cwi.icon];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesWeatherInformation *cwi = self.citiesData[indexPath.row];
    NSString *fcttext = cwi.fcttext;
    CGFloat width = 280;
    UIFont *font = [UIFont systemFontOfSize:10];
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:fcttext attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    rect = CGRectInset(rect, -50, -50);
    CGSize size = rect.size;
    return size.height;
}



@end
