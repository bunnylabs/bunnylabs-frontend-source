@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "SessionManager.j"
@import "AdminViewController.j"
@import "MenuManager.j"

var instance;

@implementation AdminManager : CPObject
{
	AdminViewController controller;
	CPMenuItem adminItem;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		controller = [[AdminViewController alloc] init];
		[[CPNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(loginStateChanged)
													 name:NOTIFICATION_LOGIN_DATA_UPDATED 
												   object:nil];

		adminItem = [[CPMenuItem alloc] initWithTitle:"Admin" action:@selector(menuItemClicked:) keyEquivalent:nil];
		[adminItem setTarget:self];
	}
	return self;
}

-(id)menuItemClicked:(id)sender
{
	if ([[DesktopManager instance] topViewController] !== controller)
	{
		[[DesktopManager instance] pushTopViewController:controller];
	}
	else
	{
		[[DesktopManager instance] removeViewController:controller];
	}

	return sender;
}

-(void)loginStateChanged
{
	[[[MenuManager instance] leftStack] removeObject:adminItem];

	if ([[SessionManager instance] isAdmin])
	{
		[[[MenuManager instance] leftStack] addObject:adminItem];
	}
	else
	{
		[[DesktopManager instance] removeViewController:controller];
	}

	[[MenuManager instance] refreshMenu];
}

+(AdminManager) instance
{
	if (!instance)
	{
		instance = [[AdminManager alloc] init];
	}
	return instance;
}

@end
