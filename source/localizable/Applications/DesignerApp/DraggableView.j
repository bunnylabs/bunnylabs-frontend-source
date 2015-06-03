@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "DraggableThingView.j"

@implementation DraggableView : DraggableThingView
{
	CPTextField label;
	CPView coverView;
	CPView view;
}

-(id)initWithElement:(id)anElement
{
	self = [super initWithElement:anElement];
	if (self)
	{
		coverView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, anElement.w, anElement.h)];
        [coverView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];

		label = [CPTextField labelWithTitle:anElement.type];
		[label setCenter:[coverView center]];
        [label setAutoresizingMask: CPViewMinXMargin |
                                        CPViewMaxXMargin |
                                        CPViewMinYMargin |
                                        CPViewMaxYMargin];

		[label setTextColor:[[CPColor grayColor] colorWithAlphaComponent:0.8]];
		[coverView setBackgroundColor:[[CPColor grayColor] colorWithAlphaComponent:0.2]];
		[label setHidden:YES];
		[coverView setHidden:YES];

		[self addSubview:label];
		[self addSubview:coverView];
	}
	return self;
}

-(void)mouseEntered:(CPEvent)anEvent
{
	[label setHidden:NO];
	[coverView setHidden:NO];
	[super mouseEntered:anEvent];
}

-(void)mouseExited:(CPEvent)anEvent
{
	[label setHidden:YES];
	[coverView setHidden:YES];
	[super mouseExited:anEvent];
}

-(void)setView:(CPView)aView
{
	var i=0, 
		subviews = [self subviews];
	for (i=0; i<subviews.length; i++)
	{
		var subview = subviews[i];
		if (subview == view)
		{
			[subview removeFromSuperview];
		}
	}

	[self addSubview:aView positioned:CPWindowBelow relativeTo:label];
	view = aView;
}

-(CPView)view
{
	return view;
}

-(CPView)coverView
{
	return coverView;
}

@end

