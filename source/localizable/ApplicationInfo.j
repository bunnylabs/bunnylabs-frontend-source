@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation ApplicationInfo : CPObject
{
	CPImage icon @accessors;
	id application @accessors;
	CPBundle bundle @accessors;
}

-(CPString)name
{
	var name = [[bundle infoDictionary] objectForKey:"CPBundleName"];
	return name;
}

+(ApplicationInfo)applicationInfoOf:(CPString)anApp withBundle:(CPBundle)aBundle
{
	var result = [[ApplicationInfo alloc] init];
    var file = [aBundle pathForResource:@"Images/icon.png"];
	var icon = [[CPImage alloc] initWithContentsOfFile:file size:CGSizeMake(200.0, 200.0)];

	[result setApplication:anApp];
	[result setIcon:icon];
	[result setBundle:aBundle];
	return result;
}

@end
