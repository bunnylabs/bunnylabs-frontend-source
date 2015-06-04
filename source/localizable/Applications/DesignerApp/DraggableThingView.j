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

-(void)mouseUp:(CPEvent)anEvent
{
	element.dropWindowX = [anEvent locationInWindow].x;
	element.dropWindowY = [anEvent locationInWindow].y;

	if ([delegate respondsToSelector:@selector(droppedElement:)])
	{
		[delegate droppedElement:element];
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