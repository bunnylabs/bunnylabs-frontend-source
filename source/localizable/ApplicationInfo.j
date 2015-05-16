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

+(ApplicationInfo)applicationInfoOf:(CPString)anApp withIcon:(CPImage)anImage withBundle:(CPBundle)aBundle
{
	var result = [[ApplicationInfo alloc] init];
	[result setApplication:anApp];
	[result setIcon:anImage];
	[result setBundle:aBundle];
	return result;
}

@end
