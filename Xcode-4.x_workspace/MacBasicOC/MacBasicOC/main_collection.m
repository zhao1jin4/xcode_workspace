#import <Foundation/Foundation.h>

@interface Widget : NSObject {
    NSInteger width;
}
@property (assign) NSInteger width;
@end

@implementation Widget

@synthesize width;

@end

int main_collection( int argc, const char *argv[] )
{
    @autoreleasepool {
        @try{
        
            //------数据
            const char *string = "Hi there, this is a C string!";
            NSData *data = [NSData dataWithBytes: string
                                          length: strlen(string) + 1];
            NSLog (@"data is %@", data);
            NSLog (@"%d byte string is '%s'", [data length], [data bytes]);
            
            //------日期时间
            NSDate *date = [NSDate date];
            NSLog (@"today is %@", date);
            
            NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: -(24 * 60 * 60)];
            NSLog (@"yesterday is %@", yesterday);
            
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
            
            NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
            NSNumber *number = [NSNumber numberWithDouble:-012.95];
            [numberFormatter setFormat:@"$#,###.00;0.00;($#,##0.00)"];//;分隔的部分: 正数,0,负数
            NSLog(@"____: %@", [numberFormatter stringFromNumber:number]);

            
            //------集合类
            
            //---NSDictionary
            NSDictionary* dic1=[NSDictionary dictionary];
            NSDictionary* dic2=[NSDictionary dictionaryWithObject:@"Bill" forKey:@"id_1"];
            NSDictionary* dic3=[NSDictionary dictionaryWithDictionary:dic2];
            NSLog(@"dic3 is :%@",dic3);
            
            NSArray *objs = [NSArray arrayWithObjects: @"lisi", @"wang", nil];
            NSArray *keys = [NSArray arrayWithObjects: @"id_2", [NSNumber numberWithInt:33], nil];
            NSDictionary* dic4=[NSDictionary dictionaryWithObjects:objs forKeys:keys];//带复数的s结尾
            NSLog(@"dic4 is :%@",dic4);
            
            NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys: @"value1", @"key1", @"value2", @"key2", nil]; // 动态参数
            NSInteger *count=[dic5 count];
            NSLog(@"dic5 is :%@,count is%d:",dic5,count);
            NSLog(@"isEqualToDictionary is :%d",[dic4 isEqualToDictionary:dic5]);
            
            keys=[dic5 allKeys];
            NSLog(@"keys is :%@",keys);
            
            id obj=[dic5 objectForKey:@"key2"];
            NSLog(@"obj is :%@",obj);
            
            //--------NSMutableDictionary
            NSMutableDictionary *mutableDict0 = [NSMutableDictionary dictionary];
            NSMutableDictionary *mutableDict1 = [[NSMutableDictionary alloc]initWithCapacity:5];
            [mutableDict1 release];
            
            NSMutableDictionary *mutableDict2 = [NSMutableDictionary dictionaryWithCapacity:10];
            [mutableDict2 setObject:@"key1"   forKey: @"hello"];
            [mutableDict2 setObject:@"123"   forKey: @"lisi"];//可用于增加,修改值
            NSLog(@"mutableDict2 setObject is :%@",mutableDict2);//这里key1怎么显示的是后面addEntriesFromDictionary修改的?????
            
            [mutableDict2 addEntriesFromDictionary:dic5];
            NSLog(@"mutableDict2 addEntriesFromDictionary is :%@",mutableDict2);
            
            [mutableDict2 setDictionary:dic5];
            NSLog(@"mutableDict2 setDictionary is :%@",mutableDict2);
            
            [mutableDict2 removeObjectForKey:@"key1"];
            NSLog(@"mutableDict2 removeObjectForKey is :%@",mutableDict2);
            
            [mutableDict2 removeObjectsForKeys:keys];
            NSLog(@"mutableDict2 removeObjectsForKeys is :%@",mutableDict2);
            [mutableDict2 removeAllObjects];
            
            //------NSRange  ,c语言的struct
            NSString * s=@"Student name:Hyman";
            NSLog(@"s length %d",[s length]);
            
            NSRange r =NSMakeRange(13,5);//location,length
            r.location=13;
            r.length=5;
            
            NSLog(@"r.location %d",r.location);
            NSLog(@"r.length %d",r.length);
            NSLog(@"%@",[s substringWithRange:r]);
            
            NSString *str1=@"the string";
            NSLog(@"%@",str1);
            NSLog(@"%@",[str1 description]);//同上
            NSLog(@"%2$d years old is %1$@",@"Johne",25);//%2$表示使用参数表中的第二个参数
            //%.2f 表示要有两位小数,%7.2f,%-7d右对齐,
            
            NSArray *theData=[NSArray arrayWithObjects:@"lisi",@"wang",nil];
            for(id item in theData) //for in 
            {
                 NSLog(@"the for in ,%@",item);
            }
          
           
            
           NSMutableArray * array = [[NSMutableArray alloc] init];
            Widget *widget = [[[Widget alloc] init] autorelease];
            [widget setWidth:10];
            [array addObject:widget];
            
            widget = [[[Widget alloc] init] autorelease];
            [widget setWidth:20];
            [array addObject:widget];
            
            widget = [[[Widget alloc] init] autorelease];
            [widget setWidth:20];
            [array addObject:widget];
            
            widget = [[[Widget alloc] init] autorelease];
            [widget setWidth:40];
            [array addObject:widget];
            
            NSNumber *value = [array valueForKeyPath:@"@count"];
            NSLog(@"Count: %f", [value doubleValue]);
            
            value = [array valueForKeyPath:@"@max.width"];
            NSLog(@"Max: %f", [value doubleValue]);
            
            value = [array valueForKeyPath:@"@min.width"];
            NSLog(@"Min: %f", [value doubleValue]);
            
            value = [array valueForKeyPath:@"@sum.width"];
            NSLog(@"Sum: %f", [value doubleValue]);

            
            /*
            //------文件IO操作
            NSFileManager *manager;
            manager = [NSFileManager defaultManager];
            
            NSString *home;
            home = [@"~" stringByExpandingTildeInPath];//在GNuSetup中的msys上  ~ 是C:\Documents and Settings\xxuser,会递归所有子目录
            
            NSDirectoryEnumerator *direnum;
            direnum = [manager enumeratorAtPath: home];
            
            NSMutableArray *files;
            files = [NSMutableArray arrayWithCapacity: 42];
            
            NSString *filename;
            while (filename = [direnum nextObject]) {
                if ([[filename pathExtension]  isEqualTo: @"jpg"]) {
                    [files addObject: filename];
                }
            }
            
             //方式一
    //         NSEnumerator *fileenum;
    //         fileenum = [files objectEnumerator];
    //         
    //         while (filename = [fileenum nextObject]) {
    //         NSLog (@"%@", filename);
    //         }
              
            //方式二
            for (NSString *filename in files) {
                NSLog (@"%@", filename);
            }
            
            //------Security 证书,加密
            //--Coder
            protocol <NSCoding>
            - (void) encodeWithCoder: (NSCoder *) coder {//是 NSCoding Protocol中的
                [coder encodeObject: name
                             forKey: @"name"];
                [coder encodeInt: magicNumber
                          forKey: @"magicNumber"];
            }
            - (id) initWithCoder: (NSCoder *) decoder {//是 NSCoding Protocol中的
                if (self = [super init]) {
                    self.name = [decoder decodeObjectForKey: @"name"];
                    self.magicNumber = [decoder decodeIntForKey: @"magicNumber"];
                }
                return (self);
            }
            - (NSString *) description { //是 NSObject Protocol 中的,当以"%@"输出时调用
            }
            NSData *freezeDried;
            freezeDried = [NSKeyedArchiver archivedDataWithRootObject: thing1];//会调用encodeWithCoder方法
            thing1 = [NSKeyedUnarchiver unarchiveObjectWithData: freezeDried];//会调用initWithCoder方法

           */
        	
        }@catch(NSException * exception)//好像不能有多个@catch,还有@throw
        {
            NSLog(@"-----NSException is===%@",[exception reasion]);
        }@finally {
            NSLog(@"-----finally---done");
        }
        
    }
	return 0;
    
}