//
//  ViewController.h
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/13.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView * _tableView;
    
    NSMutableArray * timeArray;
    
    NSMutableArray * cityNameArray;
    
    NSMutableArray * tempArray;
    
    UIButton * plusButton;
}

@property (nonnull, copy) NSString * cityString;

@end

