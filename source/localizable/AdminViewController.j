@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "AdminView.j"
@import "UserTableViewController.j"
@import "SessionTableViewController.j"

@implementation AdminViewController : CPViewController
{
	CPArray menuData;

	AdminView view;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		view = [[AdminView alloc] init]
		[self setView:view];

		menuData = [
			{name: "Users", vc: [[UserTableViewController alloc] init]},
			{name: "Sessions", vc: [[SessionTableViewController alloc] init]}
		];

		[[view menuTableView] setDelegate:self];
		[[view menuTableView] setDataSource:self];
		[[view menuTableView] reloadData];
	}
	return self;
}

-(BOOL)viewFillsDesktop
{
    return YES;
}

-(int)numberOfRowsInTableView:(CPTableView)aTableView
{
	return menuData.length;
}

-(id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aColumn row:(int)aRowIndex
{
	return menuData[aRowIndex].name;
}

-(void)tableViewSelectionDidChange:(CPNotification)aNotification
{
	var rowIndex = [[view menuTableView] selectedRow];
	if (rowIndex > -1)
	{
		while([[view anotherView] subviews].length != 0)
		{
			[[[view anotherView] subviews][0] removeFromSuperview];
		}

		var newView = [menuData[rowIndex].vc view];

		var rect = [[view anotherView] frame];
		rect.origin.x = 0;
		rect.origin.y = 0;
		[newView setFrame:rect];

		[newView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
		[[view anotherView] addSubview:newView];
	}
}

@end
