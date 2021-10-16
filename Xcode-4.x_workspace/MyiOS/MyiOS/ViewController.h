 

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyMapAnnotation.h"

@interface ViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate,//alert
                                            UIPickerViewDelegate,UIPickerViewDataSource //自定义PikcerView
                                            ,UIWebViewDelegate>
{
    NSArray *fontNames;
    NSArray *fontColors;
    NSArray *fontSizes;
    
    //---
    IBOutlet UITextField * txtName;//IBOutlet表示和界面中的组件可有绑定
	IBOutlet UIPageControl *pageControl;
	IBOutlet UIImageView *imageView1;
	IBOutlet UIImageView *imageView2;
	IBOutlet UIWebView *webView;
    
}
@property(nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain) IBOutlet UILabel  *labelFont;
@property(nonatomic,retain) IBOutlet UIPickerView  *pickerView;
@property(nonatomic,retain) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet MKMapView *map;

//---
-(void)dealloc;
-(IBAction) btnClicked1:(id)sender;//自己新加的
-(IBAction) dynamicClick:(id)sender;//为动态增加按钮的处理事件
-(IBAction) textKeybord:(id)sender;

@property (nonatomic,retain)UITextField * txtName;
@property (nonatomic,retain)UIPageControl * pageControl;
@property (nonatomic,retain)UIImageView * imageView1;
@property (nonatomic,retain)UIImageView * imageView2;
@property (nonatomic,retain)UIWebView * webView;


@end
