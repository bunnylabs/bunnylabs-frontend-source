@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "UITreeView.j"
@import "ToolBoxView.j"

var MINSIDEBARWIDTH = 200;

@implementation ContentView : CPSplitView
{
	CPView elementList;
	CPView mainView;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		[self setBackgroundColor:[CPColor redColor]];
        [self setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
        [self setDelegate:self];


        var bundle = [CPBundle bundleWithIdentifier:"net.astrobunny.bunnylabs.DesignerApp"];
		var file = [bundle pathForResource:"Images/910.jpg"];

        var mainBackground = [[CPImage alloc] initWithContentsOfFile:file];

        elementList = [[CPTabView alloc] init];
        [elementList setBackgroundColor:[CPColor darkGrayColor]];

        var item = [[CPTabViewItem alloc] init];
        [item setLabel:"Toolbox"];
        [item setView:[[ToolBoxView alloc] init]];
        [elementList addTabViewItem:item]; 

        var item = [[CPTabViewItem alloc] init];
        [item setLabel:"UI Tree"];
        [item setView:[[UITreeView alloc] init]];
        [elementList addTabViewItem:item]; 

        [self addSubview:elementList];

        mainView = [[CPView alloc] init];
        [mainView setBackgroundColor:[CPColor colorWithPatternImage:mainBackground]];

        [self addSubview:mainView];

        [self setPosition:MINSIDEBARWIDTH ofDividerAtIndex:0];
	}
	return self;
}

-(CPColor)mainView
{
	return mainView;
}

-(CPColor)elementList
{
	return elementList;
}

- (float)splitView:(CPSplitView)aSplitView constrainMinCoordinate:(float)proposedMin ofSubviewAt:(int)subviewIndex;
{
	if (subviewIndex == 0)
	{
		return MINSIDEBARWIDTH;
	}

	return proposedMin;
}

- (float)splitView:(CPSplitView)aSplitView constrainMaxCoordinate:(float)proposedMax ofSubviewAt:(int)subviewIndex;
{
	if (subviewIndex == 0)
	{
		return [aSplitView frame].size.width / 3;
	}

	return proposedMax;
}

-(void)splitView:(CPSplitView)aSplitView resizeSubviewsWithOldSize:(CGSize)oldSize
{
    var splitViewSize = [aSplitView frame].size;

    var width = [elementList frame].size.width;

    if (width > [aSplitView frame].size.width / 3)
    {
    	width = [aSplitView frame].size.width / 3;
    }

    if (width < MINSIDEBARWIDTH)
    {
    	width = MINSIDEBARWIDTH;
    }

    if (oldSize.width == 0)
    {
    	width = MINSIDEBARWIDTH;
    }

    var leftSize = [aSplitView frame].size;
    leftSize.width = width;

    [elementList setFrameSize:leftSize];
    [mainView setFrame:CGRectMake(
    	width + [aSplitView dividerThickness],
    	0,
    	splitViewSize.width - [aSplitView dividerThickness] - width,
    	splitViewSize.height)];
}

@end