@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation ApplicationInfo : CPObject
{
	CPString name @accessors;
	CPImage icon @accessors;
}

+(ApplicationInfo)applicationInfoNamed:(CPString)aName withIcon:(CPImage)anImage
{
	var result = [[ApplicationInfo alloc] init];
	[result setName:aName];
	[result setIcon:anImage];
	return result;
}

@end
