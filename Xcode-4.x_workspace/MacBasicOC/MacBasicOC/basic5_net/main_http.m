#import <Foundation/Foundation.h>

@interface MyHttpGet : NSObject <NSURLConnectionDelegate> {
	NSMutableData *data;
}
@property (retain, nonatomic) NSMutableData *data;
@end

@implementation MyHttpGet
@synthesize data;

- (void) send_get {
	NSString *address = [NSString stringWithFormat:@"http://www.baidu.com"];
	NSURL *url = [NSURL URLWithString:address];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"GET"];
    
    //异步 NSURLConnectionDelegate
    [NSURLConnection connectionWithRequest:request delegate:self ];//方式一
	//NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];//方式二
	if (data == nil) {
		data = [[NSMutableData alloc] init];
	}
	//[connection release];
    NSLog(@"----main method done.");
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[data setLength: 0];
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)inData
{
	[data appendData:inData];
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[data release];
    NSLog(@"error = %@", error);
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (data != nil && data.length > 0) {
		NSString *value = [[[NSString alloc] initWithBytes:[data bytes] length:data.length encoding:NSUTF8StringEncoding] autorelease];
		NSLog(@"%@", value);
	}
	[data release];
}
@end

int main_http (int argc, const char *argv[])
{
    //  @WebServlet(urlPatterns={"/myPost"})
    //------POST 
    /*  
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/test/myPost"];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
	[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPMethod:@"POST"];
    NSString *body = @"message=你好";
	NSData *postData = [[[NSData alloc] initWithBytes:[body UTF8String] length:[body length]] autorelease];//方式1 
	[request setHTTPBody:postData];
	//[request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
    
	[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];//同步
	
    NSLog(@"Status Code: %d", [response statusCode]);
    */
    //-----------POST 
  /*
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
   
    
    [request setURL:[NSURL URLWithString:@"http://127.0.0.1:8080/test/myPost"]];
    
    NSString *post  = [[NSString alloc] initWithFormat:@"message=%@",@"hello,world."];
  
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];//方式2
    [request setHTTPBody:postData];
     //[request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
  
  
    NSHTTPURLResponse *response = nil;
	NSError *error = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];//同步
    NSLog(@"Status Code: %d", [response statusCode]);
    
    [post release];
     */
   
    //文件上传 POST
    //------Get OK
    /* 
    MyHttpGet *get=[[MyHttpGet alloc]init];
    [get send_get];
   
    while(1)//为异步
    {
        [[NSRunLoop currentRunLoop] run];
    }
    */
    //-----Dictionary -> JSON  OK
    NSDictionary *song = [NSDictionary dictionaryWithObjectsAndKeys:@"i can fly",@"title",@"4012",@"length",@"Tom",@"Singer", nil];
    if ([NSJSONSerialization isValidJSONObject:song])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:song options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:%@",json);
    }
    //----
//    NSURL * url=[NSURL URLWithString:@"http://127.0.0.1:8080/test/myJSON"];//Fail
//    NSData *data = [NSData dataWithContentsOfURL:url];
//----
    NSString *str=@"{ \"title\" : \"i can fly\",\"Singer\" : \"Tom\",\"length\" : \"4012\" }";
    NSData *data = [[[NSData alloc] initWithBytes:[str UTF8String] length:[str length]] autorelease]; //OK
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (json == nil) {
        NSLog(@"json parse failed,error= %@\n",[error description]);
        return -1;
    }
    NSArray *songArray = [json objectForKey:@"Singer"];
    NSLog(@"song collection: %@\r\n",songArray);
    
    
    
    
    return 1;
}