#import <Foundation/Foundation.h>
#import "ZHPerson.h"
#import "ZHEngineer.h"
int main_inherit(int argc, const char *argv[])
{
    ZHPerson *p=[[ZHEngineer alloc]init];//也支持这样的多态
    p.name=@"张三";
    
    [p printDescription];
    [p release];
}