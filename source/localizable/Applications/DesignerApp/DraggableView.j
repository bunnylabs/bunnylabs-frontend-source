@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation DraggableView : CPView
{
	BOOL dragging;
	id delegate @accessors;
	id element;

	CPTextField label;
	CPView coverView;
	CPView view;

}

-(id)initWithElement:(id)anElement
{
	self = [super initWithFrame:CGRectMake(anElement.x, anElement.y, anElement.w, anElement.h)];
	if (self)
	{
		coverView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, anElement.w, anElement.h)];
        [coverView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
		[self addSubview:coverView];

		label = [CPTextField labelWithTitle:anElement.type];
		[label setCenter:[coverView center]];
		[label setTextColor:[CPColor clearColor]];
        [label setAutoresizingMask: CPViewMinXMargin |
                                        CPViewMaxXMargin |
                                        CPViewMinYMargin |
                                        CPViewMaxYMargin];
		[self addSubview:label];

		element = anElement;
		dragging = false;
	}
	return self;
}

-(void)mouseDragged:(CPEvent)anEvent
{
	var origin = [self frameOrigin];

	var newx = origin.x + [anEvent deltaX];
	var newy = origin.y + [anEvent deltaY];

	[super setFrameOrigin:CGPointMake(newx, newy)];

	element.x = newx;
	element.y = newy;

	if ([delegate respondsToSelector:@selector(updateElement:)])
	{
		[delegate updateElement:element];
	}
	[super mouseDragged:anEvent];
}

-(void)mouseEntered:(CPEvent)anEvent
{
	[label setTextColor:[[CPColor grayColor] colorWithAlphaComponent:0.8]];
	[coverView setBackgroundColor:[[CPColor grayColor] colorWithAlphaComponent:0.2]];
	[super mouseEntered:anEvent];
}

-(void)mouseExited:(CPEvent)anEvent
{
	[label setTextColor:[CPColor clearColor]];
	[coverView setBackgroundColor:[CPColor clearColor]];
	[super mouseExited:anEvent];
}

-(void)setView:(CPView)aView
{
	var i=0, 
		subviews = [self subviews];
	for (i=0; i<subviews.length; i++)
	{
		var subview = subviews[i];
		if (subview != coverView && subview != label)
		{
			[subview removeFromSuperview];
		}
	}

	[self addSubview:aView positioned:CPWindowBelow relativeTo:coverView];
	view = aView;
}

-(CPView)view
{
	return view;
}

@end
