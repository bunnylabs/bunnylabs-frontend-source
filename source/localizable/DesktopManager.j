@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "MenuManager.j"
@import "CPArray+Additions.j"

var desktopInstance;

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
	[[MenuManager instance] refreshMenu];
}

-(void)setDefaultButton:(CPButton)aButton
{
	[topWindow setDefaultButton:aButton];
}

-(CPButton)defaultButton
{
	return [topWindow defaultButton];
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