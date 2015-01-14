@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation BunnyTableView : CPView
{
	CPScrollView scrollView;
	CPTableView tableView;
	CPButton reloadButton;
}

-(id)init
{
	self = [super initWithFrame:CGRectMake(0,0,100,100)];
	if (self)
	{
		tableView = [[CPTableView alloc] init];
		[tableView setColumnAutoresizingStyle:CPTableViewUniformColumnAutoresizingStyle];
		[tableView setAlternatingRowBackgroundColors:[
			[CPColor grayColor],
			[CPColor whiteColor]
		]];

		reloadButton = [CPButton buttonWithTitle:"Reload"];
		[reloadButton setFrameOrigin:CGPointMake(3,3)];
		[reloadButton setTarget:self];
		[reloadButton setAction:@selector(reloadButtonClicked:)];
		[self addSubview:reloadButton];

		scrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(0,30,100,70)];
        [scrollView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
		[scrollView setDocumentView:tableView];

		[self addSubview:scrollView];
	}
	return self;
}

-(void)reloadButtonClicked:(id)sender
{
	if ([[self delegate] respondsToSelector:@selector(reloadButtonClicked:)])
	{
   		[[self delegate] reloadButtonClicked:self];
	}
}

-(void)reloadData
{
	[tableView reloadData];
}

-(void)addColumnNamed:(CPString)anIdentifier
{
	var column = [[CPTableColumn alloc] initWithIdentifier:anIdentifier];
	[[column headerView] setStringValue:anIdentifier];
	[column setResizingMask:CPTableColumnAutoresizingMask | CPTableColumnUserResizingMask];
	[column setEditable:YES];
	[tableView addTableColumn:column];
}

-(void)addBooleanColumnNamed:(CPString)anIdentifier
{
	var column = [[CPTableColumn alloc] initWithIdentifier:anIdentifier];
	[[column headerView] setStringValue:anIdentifier];
	[column setResizingMask:CPTableColumnNoResizing];
	[column setEditable:YES];
	[column setMaxWidth:50];
	[column setDataView:[[CPCheckBox alloc] init]];
	[tableView addTableColumn:column];
}

-(void)setDataSource:(id)aDataSource
{
	[tableView setDataSource:aDataSource];
}

-(void)setDelegate:(id)aDelegate
{
	[tableView setDelegate:aDelegate];	
}

-(id)delegate
{
	return [tableView delegate];
}

-(id)dataSource
{
	return [tableView dataSource];
}

@end