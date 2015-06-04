@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "WorkspaceModel.j"
@import "ResizableWithInfoView.j"

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

-(void)droppedElement:(id)anElement
{
	var dropPoint = [self convertPoint:CGPointMake(anElement.dropWindowX, anElement.dropWindowY) fromView:[[self window] contentView]];
	console.log(dropPoint);

	// Find first element that can be dropped into
	for (i=0; i<elements.length; i++)
	{
	}

}

-(void)addElement:(id)element
{
	var coverElement = [[ResizableWithInfoView alloc] initWithElement:element];
	[coverElement setDelegate:self];
	[self addSubview:coverElement];

	switch (element.type)
	{
		case "CPView":
		{
			var view = [[CPView alloc] initWithFrame:CGRectMake(0, 0, element.w, element.h)];
			[view setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
			[view setBackgroundColor:[CPColor redColor]];
			[coverElement setView:view];
			break;
		}

		case "CPTableView":
		{
			var view = [[CPTableView alloc] initWithFrame:CGRectMake(0, 0, element.w, element.h)];
			[view setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
			[coverElement setView:view];
			break;
		}

		case "CPButton":
		{
			var view = [[CPButton alloc] initWithFrame:CGRectMake(0, 0, element.w, element.h)];
			[view setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
			[coverElement setView:view];
			break;
		}

		case "CPTextField":
		{
			var view = [[CPTextField alloc] initWithFrame:CGRectMake(0, 0, element.w, element.h)];
			[view setBordered:YES]; 
			[view setBezeled:YES]; 
			[view setBezelStyle:CPTextFieldSquareBezel];
			[view setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
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
