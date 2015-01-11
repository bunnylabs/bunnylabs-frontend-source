@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation AdminView : CPView
{

}

-(id)init
{
	self = [super initWithFrame:CGRectMake(0,0,500,500)];
	if (self)
	{
		var splitView = [[CPSplitView alloc] initWithFrame:CGRectMake(0,0,500,500)];
        [splitView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
		[self addSubview:splitView];

		var menuTableView = [[CPTableView alloc] initWithFrame:CGRectMake(0,0,150,500)];

		var anotherView = [[CPView alloc] initWithFrame:CGRectMake(0,0,350,500)];
		[anotherView setBackgroundColor:[CPColor redColor]];

		[splitView addSubview:menuTableView];
		[splitView addSubview:anotherView];
		[splitView setPosition:150 ofDividerAtIndex:0];

		
        [self setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];

	}
	return self;
}

@end
