@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "MenuManager.j"
@import "CPArray+Additions.j"

var desktopInstance;

@implementation BreadcrumbButton : CPButton
{
	id representedObject @accessors;
}
@end

@implementation DesktopManager : CPObject
{
	CPView topWindow;
	CPView contentView;

	CPArray viewControllerStack;

}

-(id)init
{
	self = [super init];
	if (self)
	{
		topWindow = [[CPApplication sharedApplication] mainWindow];
		contentView = [topWindow contentView];
		viewControllerStack = [CPArray array];

	}
	return self;
}

-(void)desktopResized
{
	if (viewControllerStack.length != 0 && 
		[[viewControllerStack last] respondsToSelector:@selector(desktopDidResizeToRect:)])
	{
		[[viewControllerStack last] desktopDidResizeToRect:[contentView frame]];
	}

	[[[MenuManager instance] centerStack] removeAllObjects];

	var i=0;
	for (i=0; i<viewControllerStack.length; i++)
	{
		var name = viewControllerStack[i].isa.name;

		// Exclude the background
		if (name === "BunnyLabsIconViewController")
		{
			continue;
		}

		if ([viewControllerStack[i] respondsToSelector:@selector(breadcrumbName)])
		{
			name = [viewControllerStack[i] breadcrumbName];
		}

		var title = "[" + name + "]";

		var layer = [[CPMenuItem alloc] initWithTitle:"" action:nil keyEquivalent:""];

		var button = [BreadcrumbButton buttonWithTitle:title];
		[button setAction:@selector(breadcrumbMoveToTop:)];
		[button setTarget:self];
		[button setRepresentedObject: viewControllerStack[i]];

		var menu = [[CPMenu alloc] init];
		var menuCloseItem = [[CPMenuItem alloc] initWithTitle:"Close" action:@selector(breadcrumbClose:) keyEquivalent:""];
		[menuCloseItem setTarget:self];
		[menuCloseItem setRepresentedObject:viewControllerStack[i]];
		[menu addItem:menuCloseItem];
		[button setMenu:menu];

		[layer setView:button];
		[[[MenuManager instance] centerStack] addObject:layer];
	}

	[[MenuManager instance] refreshMenu];
}

-(void)breadcrumbMoveToTop:(id)sender
{
	[self pushTopViewController:[sender representedObject]];
}

-(void)breadcrumbClose:(id)sender
{
	[self removeViewController:[sender representedObject]];
}

-(void)setDefaultButton:(CPButton)aButton
{
	[topWindow setDefaultButton:aButton];
}

-(CPButton)defaultButton
{
	return [topWindow defaultButton];
}

-(CPViewController)topViewController
{
	if (viewControllerStack.length != 0)
	{
		return [viewControllerStack last];
	}
	return nil;
}

-(void)pushTopViewController:(CPViewController)aViewController
{
	[self _remove:aViewController];
	viewControllerStack = [viewControllerStack arrayByAddingObject:aViewController];
	[self _update];
}

-(void)removeViewController:(CPViewController)aViewController
{
	[self _remove:aViewController];
	[self _update];
}

-(void)_remove:(CPViewController)aViewController
{
	viewControllerStack = [viewControllerStack filterWithPredicate:function(item) 
																	{ 
																		return item !== aViewController
																	}];
}

-(void)_update
{
	while([contentView subviews].length != 0)
	{
		[[contentView subviews][0] removeFromSuperview];
	}

	if (viewControllerStack.length != 0)
	{
		var currentViewController = [viewControllerStack last];
		[contentView addSubview:[currentViewController view]];
		[[currentViewController view] setCenter:[contentView center]];

		if ([[viewControllerStack last] respondsToSelector:@selector(viewFillsDesktop)] && 
			[[viewControllerStack last] viewFillsDesktop])
		{
			[[currentViewController view] setFrame:[contentView frame]];
		}
	}

	[self desktopResized];
}


+(DesktopManager)instance
{
	if (!desktopInstance)
	{
		desktopInstance = [[DesktopManager alloc] init];
	}
	return desktopInstance;
}

@end