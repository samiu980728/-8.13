//
//  ViewController.m
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/13.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ViewController.h"

#import "searchViewController.h"

@interface ViewController ()<giveCityNameControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    timeArray = [[NSMutableArray alloc] init];
    
    //这里通过协议传值 判断是哪个城市
 //写到这里 已经完成协议传值 开始由所传的值判断接口类型
    //但是！！！没有经过结束编辑 pop回去！！！
    
    //上传网络接口
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://free-api.heweather.com/s6/weather/now?location=beijing&key=70c5ee7d3a214fefaee2fc9ca8eeb52f"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        [cityNameArray addObject:dict[@"HeWeather6"][0][@"basic"][@"location"]];
        
        [timeArray addObject:dict[@"HeWeather6"][0][@"update"][@"loc"]];
        
        [tempArray addObject:dict[@"HeWeather6"][0][@"now"][@"tmp"]];
        
        NSLog(@"%@",timeArray);
    }] resume];
    
    NSLog(@"年后------");
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell3 = nil;
    UITableViewCell * cell4 = nil;
    UITableViewCell * cell1 = nil;
    UITableViewCell * cell2 = nil;
    
    if ( indexPath.row == 0 ){
    cell1 = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if ( cell1 == nil ){
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell1.backgroundColor = [UIColor redColor];
        return  cell1;
    }
    else if ( indexPath.row == 1 ){
        cell2 = [_tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if ( cell2 == nil ){
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        return  cell2;
    }
    else if ( indexPath.row == 2 ){
        cell3 = [_tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if ( cell3 == nil ){
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        }
        return cell3;
    }
    else{
    //if ( indexPath.row == 3 ){
        cell4 = [_tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if ( cell4 == nil ){
            cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        plusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        plusButton.frame = CGRectMake(350, 5, 30, 30);
        [plusButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
            [plusButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(pressPlusButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell4.contentView addSubview:plusButton];
            
        }
    }
    return cell4;
    
}


- (void)pressPlusButton:(UIButton *)btn
{
    searchViewController * seaViewController = [[searchViewController alloc] init];
    seaViewController.delegate = self;
    
    [self.navigationController pushViewController:seaViewController animated:YES];
}

- (void)giveCityName:(NSString *)nameOfCityStr
{
    _cityString = [NSString stringWithFormat:@"%@",nameOfCityStr];
    NSLog(@"_cityString = %@",_cityString);
}

//导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pressJiaHao:)];
    self.navigationController.navigationItem.rightBarButtonItem = item;
    self.navigationItem.title = @"我的城市";
    //self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    //self.navigationController.navigationBar.tintColor = [UIColor blueColor];

}

- (void)pressJiaHao:(UIButton *)btn
{
    
}


//弄三个城市吧
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 2){
        return 40;
    }
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
