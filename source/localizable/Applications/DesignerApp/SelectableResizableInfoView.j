@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "ResizableWithInfoView.j"

@implementation SelectionRoster : CPObject
{

}

@end

@implementation SelectableResizableInfoView : ResizableWithInfoView
{
	int elementId;
}

-(id)initWithElement:(id)anElement onRoster:(SelectionRoster)aRoster
{
	self = [super initWithElement:anElement];
	if (self)
	{
		elementId = anElement.id;
	}
	return self;
}



@end