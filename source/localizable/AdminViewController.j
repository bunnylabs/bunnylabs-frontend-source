@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "AdminView.j"

@implementation AdminViewController : CPViewController
{

}

-(id)init
{
	self = [super init];
	if (self)
	{
		[self setView:[[AdminView alloc] init]];
	}
	return self;
}

-(BOOL)viewFillsDesktop
{
    return YES;
}

@end
