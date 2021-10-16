//
//  ZHMyThirdViewController.h
//  iOS_Tabbed
//
//  Created by LiZhaoJin on 13-5-17.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHMyThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    IBOutlet UISearchBar * _search;
    IBOutlet UITableView *_tableView;
    
    IBOutlet UIScrollView * scrollView;//为计算键盘大小
    BOOL keyboardShown;
    UITextField *activeField;
    
    NSArray * _depts;
    NSDictionary * _data;
}

@property UISearchBar *search;
@property UITableView *tableView;


@property  NSArray * depts;
@property  NSDictionary * data;
 

@end
