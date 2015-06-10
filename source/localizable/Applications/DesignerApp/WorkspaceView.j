@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "WorkspaceModel.j"
@import "ResizableWithInfoView.j"

@implementation WorkspaceView : CPView
{
	WorkspaceModel dataSource @accessors;
	id delegate @accessors;
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

	[self addElements:elements to:self];
}

-(void)addElements:(CPArray)elements to:(CPView)parentView
{
	var i=0;
	for (i=0; i<elements.length; i++)
	{
		[self addElement:elements[i] to:parentView];
	}
}

-(void)updateElement:(id)anElement
{
	[dataSource updateElement:anElement];
}

-(id)_findElementAtPoint:(CGPoint)aPoint inArray:(CPArray)anArray x:(int)x y:(int)y except:(id)anException
{
	var i = 0;
	for (i=0; i<anArray.length; i++)
	{
		var curElement = anArray[i];
		var rect = CGRectMake(curElement.x + x, curElement.y + y, curElement.w, curElement.h);

		if (curElement === anException)
		{
			continue;
		}

		if (CGRectContainsPoint(rect, aPoint))
		{
			var childElement = [self _findElementAtPoint:aPoint 
												 inArray:curElement.children 
													   x:x+curElement.x 
													   y:y+curElement.y
												  except:anException];
			if (childElement !== nil)
			{
				return childElement;
			}
			return curElement;
		}
	}

	return nil;
}

-(void)droppedElement:(id)anElement
{
	var dropPoint = [self convertPoint:CGPointMake(anElement.dropWindowX, anElement.dropWindowY) fromView:[[self window] contentView]];
	//console.log(dropPoint);

	// Find first element that can be dropped into
	var elements = [dataSource elements];

	var result = [self _findElementAtPoint:dropPoint inArray:elements x:0 y:0 except:anElement];

	if (result === nil)
	{
		// dropped into nothing
		if (anElement.parent !== nil)
		{
			var newPoint = [self convertPoint:CGPointMake(anElement.x, anElement.y) fromView:anElement.parent.repview];
			// coming out
			[anElement.parent.children removeObject:anElement];
			anElement.parent = nil;
			anElement.x = newPoint.x;
			anElement.y = newPoint.y;
			elements.push(anElement);
			[self reloadData];
		}
	}
	else if (anElement.parent !== result)
	{
		// dropped into something
		console.log(result);
		var parent = self;
		if (anElement.parent !== nil)
		{
			parent = anElement.parent.repview;
		}

		var newPoint = [result.repview convertPoint:CGPointMake(anElement.x, anElement.y) fromView:parent];

		if (anElement.parent === nil)
		{
			[elements removeObject:anElement];
		}
		else
		{
			[anElement.parent.children removeObject:anElement];
		}

		result.children.push(anElement);

		anElement.parent = result;
		anElement.x = newPoint.x;
		anElement.y = newPoint.y;

		[self reloadData];

	}

	if ([delegate respondsToSelector:@selector(elementsUpdated)])
	{
		[delegate elementsUpdated];
	}
}


-(void)addElement:(id)element to:(CPView)parentView
{
	var coverElement = [[ResizableWithInfoView alloc] initWithElement:element];
	[coverElement setDelegate:self];
	[parentView addSubview:coverElement];

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

	element.repview = coverElement;

	[self addElements:element.children to:[coverElement childrenView]];

}



@end
