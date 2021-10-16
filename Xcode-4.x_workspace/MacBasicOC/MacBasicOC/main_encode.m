
@implementation NSData (HEX)

- (NSString *) bytesToHex {
    char c='P';//c+1=81,P=80,十六进制50
	NSMutableString *buffer = [NSMutableString stringWithCapacity:([self length] * 2)];
	const unsigned char *bytes = [self bytes];
	
	for (NSInteger i = 0; i < [self length]; ++i) {
		[buffer appendFormat:@"%02x", (unsigned long)bytes[i]];
	}
	
	return buffer;
}

@end
@implementation NSString (HEX)

- (NSData *) hexToBytes {
    int len=sizeof(unsigned);//4
    
	NSMutableData *data = [NSMutableData data];
	for (NSInteger index = 0; index + 2 <= [self length]; index += 2)
    {
		NSRange range = NSMakeRange(index, 2);
		NSString *hex = [self substringWithRange:range];
		NSScanner *scanner = [NSScanner scannerWithString:hex];
		unsigned intValue;
    	[scanner scanHexInt:&intValue];//字串转为十六进制,转为十进制
		[data appendBytes:&intValue length:1];
	}
	return data;
}

@end


int main_encode (int argc, const char *argv[])
{
    
    //URL-encode
    NSString *address = @"http://www.someaddress.com/info?name=Packt Publishing";
	address = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)address, NULL, (CFStringRef)@"&=? ", kCFStringEncodingUTF8);
	NSLog(@"Address: %@", address);
        
    //----- encode
    NSString *name = @"Packt Publishing";
	NSData *data = [[[NSData alloc] initWithBytes:[name UTF8String] length:[name length]] autorelease];
	
	NSString *hex = [data bytesToHex];
	NSLog(@"Hex String: %@", hex);

    //----decode
    hex = @"5061636b74205075626c697368696e67";
	data = [hex hexToBytes];
	NSString *value = [[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"Value: %@", value);

    //----
    
	return 0;
} 

