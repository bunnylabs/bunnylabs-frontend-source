@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "ContentView.j"

var TOPBARHEIGHT = 30;

@implementation DesignerAppView : CPSplitView
{
	CPView topBar;
	ContentView splitView;

	CPView elementList;
	CPView mainView;
}

-(id)init
{
	self = [super initWithFrame:CPRectMake(0,0,500,500)];
	if (self)
	{
		[self setBackgroundColor:[CPColor redColor]];
        [self setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
        [self setDelegate:self];

        topBar = [[CPView alloc] init];
        [topBar setBackgroundColor:[CPColor lightGrayColor]];

        [self addSubview:topBar];

        splitView = [[ContentView alloc] init];
        elementList = [splitView elementList];
        mainView = [splitView mainView];

        [splitView setBackgroundColor:[CPColor grayColor]];

        [self addSubview:splitView];

        [self setVertical:NO];
	}
	return self;
}

- (float)splitView:(CPSplitView)aSpiltView constrainSplitPosition:(float)proposedPosition ofSubviewAt:(int)subviewIndex;
{
	if (subviewIndex == 0)
	{
		return TOPBARHEIGHT;
	}

	return proposedPosition;
}

-(void)splitView:(CPSplitView)aSplitView resizeSubviewsWithOldSize:(CGSize)oldSize
{
    var splitViewSize = [aSplitView frame].size;

    var topSize = [aSplitView frame].size;
    topSize.height = TOPBARHEIGHT;

    [topBar setFrameSize:topSize];

    [splitView setFrame:CGRectMake(
    	0,
    	TOPBARHEIGHT + [aSplitView dividerThickness],
    	splitViewSize.width,
    	splitViewSize.height - [aSplitView dividerThickness] - TOPBARHEIGHT)];
}

@end
