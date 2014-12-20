@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation BunnylabsLoginWindow : CPPanel
{
	CPView contentView;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		[self setFrame:CGRectMake(0,0,100,100)];
		[self center];
		[self setFrame:CGRectMake([self frame].origin.x - 150,[self frame].origin.y - 100,400,300) display:YES animate:YES];

	}
	return self;
}


@end
