@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "SessionManager.j"
@import "ApplicationViewController.j"
@import "MenuManager.j"

var instance;

@implementation ApplicationManager : CPObject
{
	ApplicationViewController controller;
	CPMenuItem applicationItem;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		controller = [[ApplicationViewController alloc] init];
		[[CPNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(loginStateChanged)
													 name:NOTIFICATION_LOGIN_DATA_UPDATED 
												   object:nil];

		applicationItem = [[CPMenuItem alloc] initWithTitle:"Applications" action:nil keyEquivalent:nil];
	}
	return self;
}

-(void)loginStateChanged
{
	[[[MenuManager instance] leftStack] removeObject:applicationItem];

	if ([[SessionManager instance] isLoggedIn])
	{
		[[[MenuManager instance] leftStack] addObject:applicationItem];
	}
	else
	{
		[[DesktopManager instance] removeViewController:controller];
	}

	[[MenuManager instance] refreshMenu];
}

+(ApplicationManager) instance
{
	if (!instance)
	{
		instance = [[ApplicationManager alloc] init];
	}
	return instance;
}

@end
