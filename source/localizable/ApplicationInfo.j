@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation ApplicationInfo : CPObject
{
	CPImage icon @accessors;
	id application @accessors;
}

-(CPString)name
{
	var bundle = [CPBundle bundleWithIdentifier:[application bundleIdentifier]];
	var name = [[bundle infoDictionary] objectForKey:"CPBundleName"];
	return name;
}

+(ApplicationInfo)applicationInfoOf:(CPString)anApp withIcon:(CPImage)anImage
{
	var result = [[ApplicationInfo alloc] init];
	[result setApplication:anApp];
	[result setIcon:anImage];
	return result;
}

@end
