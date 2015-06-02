@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "WorkspaceModel.j"
@import "DraggableView.j"

@implementation WorkspaceView : CPView
{
	WorkspaceModel dataSource @accessors;
}

-(id)initWithBundle:(CPBundle)bundle
{
	self = [super init];
	if (self)
	{
		var file = [bundle pathForResource:"Images/910.jpg"];
        var mainBackground = [[CPImage alloc] initWithContentsOfFile:file];
        [self setBackgroundColor:[CPColor colorWithPatternImage:mainBackground]];
        
	}
	return self;
}

-(void)reloadData
{
	var i=0, 
		subviews = [self subviews],
		elements = [dataSource elements];
	for (i=0; i<subviews.length; i++)
	{
		var subview = subviews[i];
		[subview removeFromSuperview];
	}

	[self addElements:elements];
}

-(void)addElements:(CPArray)elements
{
	var i=0;
	for (i=0; i<elements.length; i++)
	{
		[self addElement:elements[i]];
	}
}

-(void)updateElement:(id)anElement
{
	[dataSource updateElement:anElement];
}

-(void)addElement:(id)element
{
	var coverElement = [[DraggableView alloc] initWithElement:element];
	[coverElement setDelegate:self];
	[self addSubview:coverElement];

	switch (element.type)
	{
		case "CPView":
		{
			var view = [[CPView alloc] initWithFrame:CGRectMake(0, 0, element.w, element.h)];
			[view setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
			[view setBackgroundColor:[CPColor whiteColor]];
			[coverElement setView:view];
			break;
		}

		default:
		{
			break;
		}
	}
}



@end
