@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "ResizableView.j"
@import "PassthruView.j"

@implementation ResizableWithInfoView : ResizableView
{
	CPTextField infoLabel;
}

-(id)initWithElement:(id)anElement
{
	self = [super initWithElement:anElement];
	if (self)
	{
		infoLabel = [PassthruTextField labelWithTitle:"x: y: w: h:"];
		[infoLabel setFrameOrigin:CGPointMake(10,10)];
		[infoLabel setBackgroundColor:[[CPColor grayColor] colorWithAlphaComponent:0.5]];
		[infoLabel setTextColor:[[CPColor whiteColor] colorWithAlphaComponent:0.5]];


		[[self coverView] addSubview:infoLabel];
		[self update];
	}
	return self;
}

-(void)mouseEntered:(CPEvent)anEvent
{
	[super mouseEntered:anEvent];
	[self update];
}

-(void)mouseExited:(CPEvent)anEvent
{
	[super mouseExited:anEvent];
	[self update];
}

-(void)mouseDragged:(CPEvent)anEvent
{
	[super mouseDragged:anEvent];
	[self update];
}

-(void)updateElement:(id)holder
{
	[super updateElement:holder];
	[self update];
}

-(void)update
{
	var frame = [self frame];
	[infoLabel setStringValue: [CPString stringWithFormat:"x:%d y:%d w:%d h:%d", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height]];
	[infoLabel sizeToFit];
}

@end
