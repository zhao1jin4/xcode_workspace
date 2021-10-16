#import <Foundation/Foundation.h>   
 
int main_string_array( int argc, const char *argv[] )
{   
	 NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];     
	 //GNUSetup要加 -fobjc-exceptions
	 @try{
        
        //----------NSString
        NSString* hello=@"hello";
        NSString* same=[NSString stringWithString:hello ];
        NSLog(@"same =%@",same);

        NSString* format=[[NSString alloc]initWithFormat:@"%@ length is:%d",@"lisi",[@"lisi" length]];//这里用,分隔
        NSLog(@"format =%@",format);

        NSString* lower=[@"LOCWER ME" lowercaseString];
        NSString* capitalized=[@"good" capitalizedString];
        NSLog(@"lower =%@",lower);
        NSLog(@"capitalized =%@",capitalized); 

        //对齐
        NSString* username=[@"zhangsan" stringByPaddingToLength:20 withString:@"_" startingAtIndex:0];//GNUsetup,加在字串尾
        NSLog(@"username=%@",username);
        NSString* password=[@"123" stringByPaddingToLength:20 withString:@"_ " startingAtIndex:1 ];//startingAtIndex是从withString中第几个开始
        NSLog(@"password=%@",password);

        BOOL prefix=[@"http://www.sina.com.cn" hasPrefix:@"http"];
        BOOL suffix=[@"http://www.sina.com.cn" hasSuffix:@".cn"];
        NSLog(@"prefix=%d",prefix);
        NSLog(@"suffix=%d",suffix);

        //----------NSMutableString
        NSMutableString * mutableStr2=[[NSMutableString alloc]initWithCapacity:50];
        [mutableStr2 release];
        NSMutableString * mutableStr1=[NSMutableString stringWithCapacity:40];
        [mutableStr1 appendFormat:@"%@ hello",@"lisi"];//可变的
        NSLog(@"mutableStr1 appendFormat=%@",mutableStr1);

        [mutableStr1 appendString:@" !!!"];
        NSLog(@"mutableStr1 appendString=%@",mutableStr1);

        [mutableStr1 deleteCharactersInRange:NSMakeRange(mutableStr1.length - 3,3) ];//C风格的建立类NSMakeRange,第一个是位置,第二个是长度
        NSLog(@"mutableStr1 deleteCharactersInRange=%@",mutableStr1);

        [mutableStr1 insertString:@" world"  atIndex:[mutableStr1 length] ];
        NSLog(@"mutableStr1 insertString=%@",mutableStr1);

        [mutableStr1 replaceCharactersInRange:NSMakeRange(mutableStr1.length - 5,5) withString:@"good"];
        NSLog(@"mutableStr1 insertString=%@",mutableStr1);

        [mutableStr1 replaceOccurrencesOfString:@"lisi" withString:@"wang" options:NSCaseInsensitiveSearch range:NSMakeRange(0,mutableStr1.length)];
        NSLog(@"mutableStr1 replaceOccurrencesOfString=%@",mutableStr1);

        [mutableStr1 setString:@"this is new string"];
        NSLog(@"mutableStr1 setString=%@",mutableStr1);

        //----------NSArray
        NSArray *array1  = [NSArray array];//一个空的
        NSArray *array2  = [NSArray arrayWithArray:array1];

        NSString* item=[NSString stringWithFormat:@"Good"];
         
        NSDate *date=[NSDate date];//期时间
        NSNumber *value=[NSNumber numberWithInt:32];

        NSArray *array;
        array = [NSArray arrayWithObjects: @"I", @"am",item,date,value, nil];//可任何对象类型
        NSLog(@"array =%@",array);//NSArray可用%@


        BOOL is=[array containsObject:@"am"];
        NSLog(@"array containsObject? =%d",is); //打印1

        int count=[array count ];
        NSLog(@"array count=%d",count); 
        
        id  last=[array lastObject ];
        NSLog(@"array last=%@",last); //id可用%@

        id  indexObj=[array objectAtIndex:1 ];
        NSLog(@"array indexObj=%@",indexObj);

        NSUInteger index1=[array indexOfObject:@"Good" ]; 
        NSLog(@"array index1=%d",index1); 

        NSUInteger index=[array indexOfObjectIdenticalTo:item ];//NSUInteger类型,因NSString是常量,相同串不会建多个(同Java),要是相同的内存对象,不是用isEqual方法做判断
        NSLog(@"array index=%d",index); 
        
        NSArray *one  = [NSArray arrayWithObjects: @"Bill",nil];
        NSArray *two  = [NSArray arrayWithObjects: @"Bill",nil];
        NSLog(@"one == tow?,%d",[one isEqualToArray:two]);
		
        NSArray* students=[NSArray arrayWithObjects:@"Tom",@"Bill",nil];
        NSString *strAllStudent=[students componentsJoinedByString:@","];
        NSLog(@"joined is ,%@",strAllStudent);
        
         //----------NSMutableArray
         NSMutableArray *mutArray2 = [[NSMutableArray alloc]initWithCapacity:10];
         [mutArray2 release];
          
          NSMutableArray *mutArray1 = [NSMutableArray arrayWithCapacity:10];
         [mutArray1 addObject:@"Lisi"];
         [mutArray1 addObject:@"Wang"];
         [mutArray1 addObject:@"zhao"];
         NSLog(@"mutable array is ,%@",mutArray1);
        
         [mutArray1 addObjectsFromArray:students];
         [mutArray1 insertObject:@"abc" atIndex:2];
         NSLog(@"mutable array addObjectsFromArray is ,%@",mutArray1);
         
         [mutArray1 removeLastObject];
         [mutArray1 removeObject:@"Lisi"];
         [mutArray1 removeObjectAtIndex:0];
         [mutArray1 removeObjectIdenticalTo:@"Tom"];
          NSLog(@"mutable array after remove is ,%@",mutArray1);
         
         NSArray *toRemove =[NSArray arrayWithObjects:@"abc",@"Wang",nil];
         [mutArray1 removeObjectsInArray:toRemove];
         NSLog(@"mutable array arrayWithObjects is ,%@",mutArray1);
         
         NSArray *myData=[NSArray arrayWithObjects:@"One",@"two",@"three",@"four",@"five",nil];
         NSMutableArray *mutArray3 = [NSMutableArray arrayWithArray:myData];
         [mutArray3 removeObjectsInRange:NSMakeRange(2, 2)];
         NSLog(@"mutable array removeObjectsInRange is ,%@",mutArray3);
         
         [mutArray3 replaceObjectAtIndex:1 withObject:@"replaced"];
         NSLog(@"mutable array replaceObjectAtIndex is ,%@",mutArray3);
         
         [mutArray3 removeAllObjects];
         [mutArray3 setArray:myData];
          NSLog(@"mutable array removeAllObjects,setArray is ,%@",mutArray3);
        
         
         @throw [NSException exceptionWithName:@"myException" reason:@"this is my exception" userInfo:nil];
	}@catch(NSException * exception)//好像不能有多个@catch,还有@throw
	{
		NSLog(@"-----NSException is===%@",[exception reasion]);
	}@finally {  
		NSLog(@"-----finally---done");
    }
	
	
	[pool release];    
	return 0;   
} 
//gcc -o string_test string_test.m -ID:/Program/GNUstep/GNUstep/System/Library/Headers -fconstant-string-class=NSConstantString -LD:/Program/GNUstep/GNUstep/System/Library/Libraries -lobjc -lgnustep-base -fobjc-exceptions
