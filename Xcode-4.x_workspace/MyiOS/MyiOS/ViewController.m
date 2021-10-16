 
#import "ViewController.h"

@implementation ViewController

 
@synthesize txtName; //文本框的Attribute inspector->复选Auto Enable return key,开始未输入文本前enter是不可用的
@synthesize pageControl;
@synthesize imageView1;
@synthesize imageView2;
@synthesize webView;

//组件
@synthesize datePicker;
@synthesize labelFont;
@synthesize pickerView;
@synthesize progress;

//右击文本框把Did End On Exit 事件关联,在文本框输入文本后按enter键盘才会消失,否则键盘不会消失
-(IBAction) textKeybord:(id)sender{
    
}

- (void)viewDidLoad //当程序启动时初始化时会
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[txtName becomeFirstResponder];//使用键盘
    
    //---动态增加组件
    NSString * s=@"这是一个很长的字串,要看到换行效果";
    UIFont * font=[UIFont fontWithName:@"Arial" size:50.f];
    CGSize size=CGSizeMake(320, 2000);
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectZero];
    [label2 setNumberOfLines:0];
    //根据字串的的长度,字体大小,计算出空间
    CGSize labelSize=[s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    label2.frame=CGRectMake(0,0,labelSize.width,labelSize.height);
    label2.textColor=[UIColor blackColor];
    label2.font=font;
    label2.text=s;
    [self.view addSubview:label2];
    //[label2 release];
    //动态增加事件处理
    UIButton *button =[UIButton buttonWithType:UIButtonTypeRoundedRect];//UIButtonTypeContactAdd
    button.frame=CGRectMake(100,230,80,40);
    [button setTitle:@"动态按钮加事件" forState:UIControlStateNormal];
    button.tag=6;
    [button addTarget:self action:@selector(dynamicClick:) forControlEvents:UIControlEventTouchUpInside];//方法后要加:
    //[button removeTarget:self action:@selector(dynamicClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //---DatePicker组件
    NSDate * date=[NSDate date];
    [datePicker setDate:date animated:YES];
    //---UIPickerView组件
    fontNames=[UIFont familyNames];
    fontColors=[NSArray arrayWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],nil];
    fontSizes=[NSArray arrayWithObjects:@"10",@"20",@"30",@"40",nil];
    pickerView.dataSource=self;//实现协议UIPickerViewDelegate,UIPickerViewDataSource
    pickerView.delegate=self;
    //设置初始选中数据中间部分
    [pickerView selectRow:[fontNames count]/2 inComponent:0 animated:YES];
    [pickerView selectRow:[fontColors count]/2 inComponent:1 animated:YES];
    [pickerView selectRow:[fontSizes count]/2 inComponent:2 animated:YES];
    //---ProgressView
    progress.progress=0.7;//范围0-1 ,可使用NSTimer
    //---MapKit 要加库 和 #import <MapKit/MapKit.h>
    //MKMapView *map=[MKMapView alloc]initWithFrame:(CGRect);
    CLLocationCoordinate2D center;
    center.latitude = 31.23136;//上海人民广场位于北纬31度23分,东经121度47分。
    center.longitude= 121.47004;
    MKCoordinateSpan span;
    span.latitudeDelta=0.005;//精度
    span.longitudeDelta=0.005;
    MKCoordinateRegion region={center,span};
    [self.map setRegion:region];
    //地图标记,要实现协议 MKAnnotation
    MyMapAnnotation *anno=[[MyMapAnnotation alloc]initWithLocation:center];
    [self.map addAnnotation:anno];
    
    //---弹出对话框
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"这是AlertView" message:[txtName text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"操作1",@"操作2", nil];
    [alert show];
    //[alert release];
    
    //---图片浏览
    [imageView1 setImage:[UIImage imageNamed:@"Beach.jpg"]];
    [imageView1 setHidden:NO];
    [imageView2 setHidden:YES];
    [pageControl addTarget:self action:@selector(pageTurning:)  forControlEvents:UIControlEventValueChanged];//方法后要加:
    
    //---WebView
         
    NSString *filePathtest = [[NSBundle mainBundle] pathForResource:@"test.js" ofType:nil];//为什么不能加载js文件???
  
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hello.html" ofType:nil];//本地URL
    NSURL *url = [NSURL fileURLWithPath:path];

    //--OC调用JS
    //NSURL *url=[NSURL URLWithString:@"http://www.google.com.hk"]; //远程URL http://threejs.org
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    //--JS调用OC ,UIWebViewDelegate ,shouldStartLoadWithRequest
     webView.delegate=self;  
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType //UIWebViewDelegate
{
    //这是通过自定义仿问URL的方式,HTML文件中用document.location = "protocol://xxx",估计要用ajax请求,可是如何向JS返回结果???
    
    //获取时 url中含有中文
    NSString *urlStr = [[request.URL absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //传输时 url中含有中文,js的方法 encodeURI
    //NSString *rateCardsName_CN=[[NSString stringWithFormat:@"%@",xxx]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
    NSString* rurl=[[request URL] absoluteString];
    if ([rurl hasPrefix:@"protocol://"]) {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Called by JavaScript"
                                                     message:@"You've called iPhone provided control from javascript!!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
        return false;
    }
    return true;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView //UIWebViewDelegate的方法
{
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"%@",currentURL);
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",title);
    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction() { "
     "var field = document.getElementsByName('q')[0];"
     "field.value='中国';"
     "document.forms[0].submit();"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
    //---
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hello" ofType:@"js"];//为什么不能加载js文件???
//    NSError * err=[[NSError alloc]init];
//    NSString *jsString = [[NSString alloc] initWithContentsOfFile:filePath usedEncoding:NSUTF8StringEncoding error:&err];
//    NSLog(@"%@",jsString);
}

/*
-(void)loadView //UIViewController的方法
{
    UIView* view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];//屏幕大小
    view.backgroundColor=[UIColor lightGrayColor];
    CGRect frame =CGRectMake(10,15,300,20);
    UILabel *label =[[UILabel alloc]initWithFrame:frame];
    label.textAlignment= NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];//变透明色
    label.font=[UIFont fontWithName:@"Verdana" size:20];
    label.text=@"动态生成的label";
    label.tag=1000;

    
    UIButton *button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"动态按钮" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(30, 30, 200, 60)];//要设frame才可见
    button.tag=2000;
    button.backgroundColor=[UIColor clearColor];
    
    [view addSubview:label];
    [view addSubview:button];
    
    [view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    
    for (int i=0;i<[view.subviews count];i++)
    {
        UIView *item=[view.subviews objectAtIndex:i];
        NSLog(@"第%d个组件的tag=%d",i,item.tag);
    }
    self.view=view;//修改view
    //[label release];
}
 */
-(void)pageTurning:(UIPageControl*)pageController //翻页,函数形式
{
    NSInteger goPage=[pageController currentPage];
    switch (goPage) {
        case 0:
            [imageView1 setImage:[UIImage imageNamed:@"Beach.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"Brushes.jpg"]];
            break;
        case 1:
            [imageView1 setImage:[UIImage imageNamed:@"Brushes.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"Circles.jpg"]];
            break;
        case 2:
            [imageView1 setImage:[UIImage imageNamed:@"Circles.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"Beach.jpg"]];
            break;
        default:
            break;
    }
    
    //left 动画
    [UIView beginAnimations:@"flipping view" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:imageView1 cache:YES];
    [UIView commitAnimations];
    //rigth 动画
    [UIView beginAnimations:@"flipping view" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:imageView2 cache:YES];
    [UIView commitAnimations];
}

-(IBAction) dynamicClick:(id)sender//为动态增加按钮的处理事件
{
    NSLog(@"这个是动态处理方法");
    
    [txtName resignFirstResponder];//让键盘消失
}

-(IBAction) btnClicked1:(id)sender//Touch up inside 事件
{
    UIButton *which=(UIButton*)sender;
    NSString *strBtnTag=[NSString stringWithFormat:@"%@  's button tag is %d",[which currentTitle],[which tag] ];//tag组件的唯一标识
    NSLog(@"%@",strBtnTag);
    
    //UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"title" message:[txtName text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"操作1",@"操作2", nil];
    //[alert show]; //会调用alertView
    //[alert release];
    
    UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:@"这是ActionSheet" delegate:self cancelButtonTitle:@"Cancle" destructiveButtonTitle:@"quite" otherButtonTitles:@"操作1",@"操作2", nil ];
    [sheet showInView:self.view];//会调用actionSheet
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//<UIAlertViewDelegate>中的函数, otherButtonTitles 的响应函数
{
    printf("AlertView 按钮索引是：%d\n",buttonIndex);//操作1对应的buttonIndex是1 ,cancleButtonTitile对应的buttonIndex是0
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //是UIActionSheet中的方法,
    printf("ＡctionSheet 按钮索引是：%d\n",buttonIndex);
}

//当DatePicker改变时valueChange事件调用这个,
-(IBAction)dateChanged:(id)sender
{
    NSDate *selDate=[datePicker date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    //[formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSLog(@"NSDateFormatter: %@",[formatter stringFromDate:selDate]);
    //[formatter release];
    NSCalendar* calendar =[NSCalendar currentCalendar];
    NSDateComponents* component=[calendar components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:selDate];
    NSLog(@"NSCalendar: %d-%02d", [component year],[component month]);
}

#pragma mark ---开始自定义PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{ //UIPickerViewDataSource 的方法
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{//UIPickerViewDataSource 的方法
    if(component == 0)
        return [fontNames count];
    else if(component == 1)
        return [fontColors count];
    else if(component == 2)
        return [fontSizes count];
    return -1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{//UIPickerViewDelegate 的方法
    if(component == 0)
        return 200.f;
    else if(component == 1)
        return 90.0f;
    else if(component == 2)
        return 50.0;
    return 0.0f;
}

 -(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{ //UIPickerViewDelegate 的方法
    return 50.0f;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{//UIPickerViewDelegate 的方法,自定义内部组件
    CGFloat  width=[self pickerView:pickerView widthForComponent:component];//调用自己实现的,得到宽
    CGFloat  height=[self pickerView:pickerView rowHeightForComponent:component];
    UIView *myView=[[UIView alloc]init];
    myView.frame=CGRectMake(0.0f,0.0f,width,height-10.0f);
    UILabel *label=[[UILabel alloc]init];
    label.tag=200;//为了后面的选择用
    label.frame=myView.frame;
    [myView addSubview:label];
    //[label release];
   
    if(component ==0)
        label.text=[fontNames objectAtIndex:row];
    else if(component==1)
        label.backgroundColor=[fontColors objectAtIndex:row];
    else if(component==2)
        label.text=[fontSizes objectAtIndex:row];
    
    return myView;
}

/*-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
 {//UIPickerViewDataSource 的方法,titleForRow和viewForRow只能有一个方法存在
    return [fontNames objectAtIndex:row];
}*/

//UIPickerViewDelegate  的方法,选中后的回调
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   //UIFont 不能修改字体名,只能每初始化
    UIView *viewFont = [pickerView viewForRow:[pickerView selectedRowInComponent:0] forComponent:0];//只有自己实现了ViewForRow方法,才可调用
    UIView *viewColor = [pickerView viewForRow:[pickerView selectedRowInComponent:1] forComponent:1];
    UIView *viewSize = [pickerView viewForRow:[pickerView selectedRowInComponent:2] forComponent:2];

    UILabel *selectFont=(UILabel*)[viewFont viewWithTag:200];
    UILabel *selectColor=(UILabel*)[viewColor viewWithTag:200];
    UILabel *selectSize=(UILabel*)[viewSize viewWithTag:200];

    UIFont *font=[UIFont fontWithName:[selectFont text] size:[selectSize.text floatValue]];
    [labelFont setFont:font];
    [labelFont setTextColor:selectColor.backgroundColor];
}
#pragma mark ---结束自定义PickerView

-(void)dealloc{
   // [super dealloc];
    printf("dealloc !!!\n");
}
/*
//Xcode-4.5是不推荐使用，在Xcode 4.5 默认没有这个方法
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //自己修改的
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait ||  //竖向的
            toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft );//Home键在左边的横向

}
*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
