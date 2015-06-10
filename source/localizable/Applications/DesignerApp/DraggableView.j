@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "DraggableThingView.j"
@import "PassthruView.j"

@implementation DraggableView : DraggableThingView
{
	CPTextField label;
	CPView coverView;
	CPView childrenView;
	CPView view;
}

-(id)initWithElement:(id)anElement
{
	self = [super initWithElement:anElement];
	if (self)
	{
		coverView = [[PassthruView alloc] initWithFrame:CGRectMake(0, 0, anElement.w, anElement.h)];
        [coverView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];

		label = [PassthruTextField labelWithTitle:anElement.type];
		[label setCenter:[coverView center]];
        [label setAutoresizingMask: CPViewMinXMargin |
                                        CPViewMaxXMargin |
                                        CPViewMinYMargin |
                                        CPViewMaxYMargin];

        childrenView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, anElement.w, anElement.h)];
        [childrenView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];

		[label setTextColor:[[CPColor grayColor] colorWithAlphaComponent:0.8]];
		[coverView setBackgroundColor:[[CPColor grayColor] colorWithAlphaComponent:0.2]];
		[coverView setHidden:YES];

		[coverView addSubview:label];
		[self addSubview:childrenView];
		[self addSubview:coverView];
	}
	return self;
}

-(void)mouseEntered:(CPEvent)anEvent
{
	[coverView setHidden:NO];

	[super mouseEntered:anEvent];

	[[self superview] mouseExited:anEvent];
}

-(void)mouseExited:(CPEvent)anEvent
{
	[coverView setHidden:YES];

	[super mouseExited:anEvent];

	// basically, convert point to superview space
	// and see if the mouse is in the superview, if it is tell it we have gone in it
	var hitTestPoint = [[self superview] convertPoint:[anEvent locationInWindow] fromView:[[self window] contentView]];

	if ([[self superview] hitTest:hitTestPoint] === [self superview])
	{
		[[self superview] mouseEntered:anEvent];
	}
}

-(void)mouseDragged:(CPEvent)anEvent
{
	[super mouseDragged:anEvent];
}

-(void)mouseUp:(CPEvent)anEvent
{
	[super mouseUp:anEvent];
}

-(void)mouseDown:(CPEvent)anEvent
{
	[super mouseDown:anEvent];
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

-(CPView)childrenView
{
	return childrenView;
}

@end

