@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>


@implementation AdminView : CPView
{
	CPTableView menuTableView @accessors;
	CPScrollView scrollTableView;
	CPView anotherView @accessors;

}

-(id)init
{
	self = [super initWithFrame:CGRectMake(0,0,500,500)];
	if (self)
	{
		var splitView = [[CPSplitView alloc] initWithFrame:CGRectMake(0,0,500,500)];
		[splitView setDelegate:self];
        [splitView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
		[self addSubview:splitView];

		menuTableView = [[CPTableView alloc] initWithFrame:CGRectMake(0,0,150,500)];
		[menuTableView setHeaderView:nil];
		[menuTableView addTableColumn:[[CPTableColumn alloc] initWithIdentifier:"menuitems"]];

		scrollTableView = [[CPScrollView alloc] initWithFrame:CGRectMake(0,0,150,500)];
		[scrollTableView setDocumentView:menuTableView];

		[splitView addSubview:scrollTableView];

		anotherView = [[CPView alloc] initWithFrame:CGRectMake(0,0,350,500)];
		[anotherView setBackgroundColor:[CPColor grayColor]];

		[splitView addSubview:anotherView];

        [self setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];


	}
	return self;
}

-(float)splitView:(CPSplitView)aSpiltView constrainSplitPosition:(float)proposedPosition ofSubviewAt:(int)subviewIndex
{
	if (subviewIndex === 0)
	{
		return 150;
	}
	return proposedPosition;
}

-(void)splitView:(CPSplitView)aSplitView resizeSubviewsWithOldSize:(CGSize)oldSize
{
    var splitViewSize = [aSplitView frame].size;

    var leftSize = [aSplitView frame].size;
    leftSize.width = 150;

    [scrollTableView setFrameSize:leftSize];
    [anotherView setFrame:CGRectMake(
    	150 + [aSplitView dividerThickness],
    	0,
    	splitViewSize.width - [aSplitView dividerThickness] - 150,
    	splitViewSize.height)];
}

@end
