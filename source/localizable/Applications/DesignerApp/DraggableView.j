@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>



@implementation DraggableThingView : CPView
{
	id element;
	id delegate @accessors;

}

-(id)initWithElement:(id)anElement
{
	self = [super initWithFrame:CGRectMake(anElement.x, anElement.y, anElement.w, anElement.h)];
	if (self)
	{
		element = anElement;
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

	element.dx = [anEvent deltaX];
	element.dy = [anEvent deltaY];

	if ([delegate respondsToSelector:@selector(updateElement:)])
	{
		[delegate updateElement:element];
	}
}

-(id)element
{
	return element;
}

-(void)modifyElement:(id)theElement
{
	element = theElement;

	if ([delegate respondsToSelector:@selector(updateElement:)])
	{
		[delegate updateElement:element];
	}
}

@end


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


@implementation ResizableView : DraggableView
{
	var holders;
}

-(id)initWithElement:(id)anElement
{
	self = [super initWithElement:anElement];
	if (self)
	{
		holders = {};
		holders["tl"] = [self _holderFor:"tl"];
		holders["t" ] = [self _holderFor:"t" ];
		holders["tr"] = [self _holderFor:"tr"];
		holders["l" ] = [self _holderFor:"l" ];
		holders["r" ] = [self _holderFor:"r" ];
		holders["bl"] = [self _holderFor:"bl"];
		holders["b" ] = [self _holderFor:"b" ];
		holders["br"] = [self _holderFor:"br"];

	}
	return self;
}

-(DraggableThingView)_holderFor:(CPString)pos
{
	var holderpos = [self _holderPositionFor:pos];
	var holder = [[DraggableThingView alloc] initWithElement:holderpos];
	[holder setBackgroundColor:[[CPColor grayColor] colorWithAlphaComponent:0.8]];
	[holder setAutoresizingMask:holderpos.autosizemask];
	[holder setDelegate:self];
	[[super coverView] addSubview:holder];
	return holder;
}

-(id)_holderPositionFor:(CPString)pos
{
	var x = Math.floor([self frame].size.width / 2) - 3, 
		y = Math.floor([self frame].size.height / 2) - 3, 
		h = 6, 
		w = 6,
		autosizemask = CPViewMinXMargin |
						CPViewMaxXMargin |
						CPViewMinYMargin |
						CPViewMaxYMargin;

	if (pos.includes("t")) { autosizemask &= ~CPViewMinYMargin; y = 0; }
	if (pos.includes("b")) { autosizemask &= ~CPViewMaxYMargin; y = [self frame].size.height - 6; }
	if (pos.includes("r")) { autosizemask &= ~CPViewMaxXMargin; x = [self frame].size.width - 6; }
	if (pos.includes("l")) { autosizemask &= ~CPViewMinXMargin; x = 0; }

	return {x:x, y:y, w:w, h:h, type:pos, autosizemask:autosizemask};

}

-(void)updateElement:(id)holder
{
	var x = [self frame].origin.x;
	var y = [self frame].origin.y;
	var w = [self frame].size.width;
	var h = [self frame].size.height;


	var dx = holder.dx;
	var dy = holder.dy;

	var theElement = [self element];

	if (holder.type.includes("t")) { theElement.y = y+dy; theElement.h = h-dy; }
	if (holder.type.includes("b")) { theElement.h = h+dy; }
	if (holder.type.includes("r")) { theElement.w = w+dx; }
	if (holder.type.includes("l")) { theElement.x = x+dx; theElement.w = w-dx; }

	//console.log(theElement);

	[self setFrame:CGRectMake(theElement.x, theElement.y, theElement.w, theElement.h)];

	[self modifyElement:theElement];


	var origpos = [self _holderPositionFor:holder.type];
	[holders[holder.type] setFrameOrigin:CGPointMake(origpos.x,origpos.y)];

}

-(void)mouseEntered:(CPEvent)anEvent
{
	[super mouseEntered:anEvent];
}

-(void)mouseExited:(CPEvent)anEvent
{
	[super mouseExited:anEvent];
}

@end
