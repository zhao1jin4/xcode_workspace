 

 int main_xml (int argc, const char *argv[])
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"models" ofType:@"xml" ];//为何返回nil??
    
	path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", path]];
	
	NSError *error;
	NSXMLDocument *document = [[NSXMLDocument alloc] initWithContentsOfURL:url options:NSXMLDocumentTidyXML error:&error];
	
	NSXMLElement *rootElement = [document rootElement];
	if (rootElement != nil) {
		NSArray *models = [rootElement elementsForName:@"model"];
		if (models != nil) {
			for (NSXMLElement *element in models) {
				NSXMLNode *type = [element attributeForName:@"type"];
				NSLog(@"Model: %@ Type: %@", [element stringValue], [type stringValue]);
			}
		}
	}
	
	[document release];
 
	return 0; 
} 

