#import <Foundation/Foundation.h>


void default_storage()
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if ([defaults objectForKey:@"Publisher"]) {
		NSLog(@"Found: %@", [defaults objectForKey:@"Publisher"]);
	} else {
		NSLog(@"Did not find Publisher.");
	}
    
	
	NSInteger count = [defaults integerForKey:@"Count"];
	NSLog(@"Current Count: %d", count);
	count++;
	
	[defaults setInteger:count forKey:@"Count"];
	[defaults setObject:@"Packt Publishing" forKey:@"Publisher"];
    
}


@interface Data : NSObject <NSCoding> {
	NSInteger version;
	NSDate *date;
	NSMutableArray *names;
}

@property (assign) NSInteger version;
@property (retain) NSDate *date;
@property (retain) NSMutableArray *names;

@end


@implementation Data

@synthesize version;
@synthesize date;
@synthesize names;

- (void) encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeInteger:[self version] forKey:@"version"];
	[encoder encodeObject:date forKey:@"date"];
	[encoder encodeObject:names forKey:@"names"];
}

- (id) initWithCoder:(NSCoder *)decoder {
	self = [super init];
	if (self != nil) {
		version = [decoder decodeIntegerForKey:@"version"];
		date = [[decoder decodeObjectForKey:@"date"] retain];
		names = [[[NSMutableArray alloc] initWithArray:[decoder decodeObjectForKey:@"names"]] retain];
	}
	
	return self;
}

@end


void archvie()
{
    Data *data = [[Data alloc] init];
	[data setVersion:1];
	[data setDate:[NSDate new]];
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:@"Ben Franklin"];
	[array addObject:@"Sam Adams"];
	[array addObject:@"George Washington"];
	
    [data setNames:array];
	
	NSArray *applicationSupportPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString *path = [applicationSupportPaths objectAtIndex:0];
	path = [path stringByAppendingPathComponent:@"Packt Publishing"];
	[[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
	path = [path stringByAppendingPathComponent:@"SavedDataObject.data"];
	
	[NSKeyedArchiver archiveRootObject:data toFile:path];
    
    [array release];
    [data release];

}
void unarchive()
{
    NSArray *applicationSupportPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString *path = [applicationSupportPaths objectAtIndex:0];
	path = [path stringByAppendingPathComponent:@"Packt Publishing"];
	[[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
	path = [path stringByAppendingPathComponent:@"SavedDataObject.data"];
	
	Data *data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	
	NSLog(@"Version: %d", [data version]);
	NSLog(@"   Date: %@", [data date]);
	
	NSArray *array = [data names];
	for (NSString *name in array) {
		NSLog(@"   Name: %@", name);
	}

}


int main_storage( int argc, const char *argv[] )
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
   
    //default_storage();
   
    //archvie();
    unarchive();
    
    
    
	[pool release];
	return 0;
}


