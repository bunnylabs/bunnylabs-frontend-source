@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "DraggableView.j"

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

	if (pos.indexOf("t") != -1) { autosizemask &= ~CPViewMinYMargin; y = 0; }
	if (pos.indexOf("b") != -1) { autosizemask &= ~CPViewMaxYMargin; y = [self frame].size.height - 6; }
	if (pos.indexOf("r") != -1) { autosizemask &= ~CPViewMaxXMargin; x = [self frame].size.width - 6; }
	if (pos.indexOf("l") != -1) { autosizemask &= ~CPViewMinXMargin; x = 0; }

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

	if (holder.type.indexOf("t") != -1) { theElement.y = y+dy; theElement.h = h-dy; }
	if (holder.type.indexOf("b") != -1) { theElement.h = h+dy; }
	if (holder.type.indexOf("r") != -1) { theElement.w = w+dx; }
	if (holder.type.indexOf("l") != -1) { theElement.x = x+dx; theElement.w = w-dx; }

	//console.log(theElement);

	[self setFrame:CGRectMake(theElement.x, theElement.y, theElement.w, theElement.h)];

	[self modifyElement:theElement];


	var origpos = [self _holderPositionFor:holder.type];
	[holders[holder.type] setFrameOrigin:CGPointMake(origpos.x,origpos.y)];

}

@end
