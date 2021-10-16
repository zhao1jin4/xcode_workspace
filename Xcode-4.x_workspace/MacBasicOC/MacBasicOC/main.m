//
//  main.m
//  MacBasicOC
//
//  Created by zhaojin  on 12-10-3.
//  Copyright (c) 2012年 zhaojin . All rights reserved.
//
#import <Foundation/Foundation.h>

void formater()
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:162000];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"formattedDateString: %@", formattedDateString);
    
    
    
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    NSNumber *number = [NSNumber numberWithDouble:-012.95];
    [numberFormatter setFormat:@"$#,###.00;0.00;($#,##0.00)"];//;分隔的部分: 正数,0,负数
    NSLog(@"____: %@", [numberFormatter stringFromNumber:number]);

       
}



 int main (int argc, const char *argv[])
{
    @autoreleasepool {
    //NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    //------------------------
      
        NSLog(@"Hello World!");
        
        
        //return main_string_array(argc,argv);
        //return main_collection(argc,argv);
        
        //return main_proxy(argc,argv);
        //return main_block(argc,argv);
        
        //return main_grammar(argc,argv);
        //return main_memory(argc,argv);
        //return main_category(argc,argv);
               
        //return main_inherit(argc,argv);
        //main_storage(argc,argv);
        //main_notification(argc,argv);
        //main_timer(argc,argv);
        //main_xml(argc,argv);//未成功
        //main_encode();
        //formater();
        //main_http(argc,argv);
        //main_thread(argc,argv);
		main_kvo(argc,argv);//OK
        //-------------
       
        //return main_c(argc,argv);//未成功
       
        
	//------------------------
   //[pool drain];//drain是什么意思
    }
	return 0; 
} 

