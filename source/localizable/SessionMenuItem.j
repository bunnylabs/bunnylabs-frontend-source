@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation SessionMenuItem : CPMenuItem
{
}

-(id)init
{
	self = [super initWithTitle:"Not logged in" action:@selector(menuItemClicked:) keyEquivalent:nil];
	if (self)
	{

	}
	return self;
}

@end