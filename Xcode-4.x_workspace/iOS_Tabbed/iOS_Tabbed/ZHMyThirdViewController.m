//
//  ZHMyThirdViewController.m
//  iOS_Tabbed
//
//  Created by LiZhaoJin on 13-5-17.
//  Copyright (c) 2013年 LiZhaoJin. All rights reserved.
//

#import "ZHMyThirdViewController.h"

@interface ZHMyThirdViewController ()

@end

@implementation ZHMyThirdViewController

@synthesize search=_search;
@synthesize  tableView=_tableView;

@synthesize  depts=_depts;
@synthesize  data=_data;
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *path =[[NSBundle mainBundle]pathForResource:@"table_data" ofType:@".plist"];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    self.depts = [dict allKeys];
    self.data=dict;
    
    
    //self.search.autocorrectionType=UITextAutocorrectionTypeYes;
    //self.tableView.tableHeaderView=self.search;
  }

-(void)viewDidAppear:(BOOL)animated
{
    keyboardShown=NO;
    //注册键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)  name:UIKeyboardDidShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

//UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.depts count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *dept=[self.depts objectAtIndex:section ];
    NSArray * emps= [self.data  objectForKey:dept];
    return [emps count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  [self.depts objectAtIndex:section ];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];//对数量较多的单元格,可重新使用不显示在屏幕中的
    if(cell==nil)
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    NSArray* depts=[self.data objectForKey: [self.depts objectAtIndex:indexPath.section]];
    cell.textLabel.text=[depts objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"apple.jpg"];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"-----";
}

//UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中的组号=%d,行号=%d",indexPath.section,indexPath.row);
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.row%2;
}


//--键盘
- (void)textFieldDidBeginEditing:(UITextField *)textField  //UITextFieldDelegate
{
    activeField = textField;
}
 
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (keyboardShown)
        return;
    NSDictionary* info = [aNotification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];//得到键盘的大小
    CGSize keyboardSize = [aValue CGRectValue].size;//iPad高318
    CGRect viewFrame = [scrollView frame];//高376
    viewFrame.size.height -= keyboardSize.height;//scrollView变小
    scrollView.frame = viewFrame;
    CGRect textFieldRect = [activeField frame];//下面的是y=317
    [scrollView scrollRectToVisible:textFieldRect animated:YES];//滚动srollView到指定组件
    keyboardShown = YES;
}
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
//    NSDictionary* info = [aNotification userInfo];
//    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [aValue CGRectValue].size;
//    CGRect viewFrame = [scrollView frame];//高怎么还是376 ???
//    viewFrame.size.height += keyboardSize.height;
//    scrollView.frame = viewFrame;
    keyboardShown = NO;
}

@end
