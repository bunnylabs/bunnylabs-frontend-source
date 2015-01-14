@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "SessionManager.j"
@import "BunnyTableView.j"

@implementation SessionTableViewController : CPViewController
{
	BunnyTableView tableView;

	id sessionTable;

	int currentStatusCode;
	CPString currentData;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		tableView = [[BunnyTableView alloc] init];
		[tableView setDataSource:self];
		[tableView setDelegate:self];

		[tableView addColumnNamed:"userid"];
		[tableView addColumnNamed:"loginTime"];
		[tableView addColumnNamed:"ip"];
		[tableView addColumnNamed:"lastUseTime"];
		[tableView addColumnNamed:"expiryTime"];

		[self reloadData];
		[self setView:tableView];
	}
	return self;
}

-(void)reloadData
{
	[[SessionManager instance] get:"/admin/sessions" andNotify:self];
}

-(void)reloadButtonClicked:(id)sender
{
	[self reloadData];
}

-(int)numberOfRowsInTableView:(CPTableView)aTableView
{
	if (sessionTable)
	{
		return sessionTable.length;
	}
	return 0;
}

-(id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aColumn row:(int)aRowIndex
{
	return sessionTable[aRowIndex][ [aColumn identifier] ];
}

-(BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)aTableColumn row:(int)rowIndex
{
	return NO;
}
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error
{
}

-(void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response
{
    currentStatusCode = [response statusCode];
}

-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data
{
    currentData = data;
}

-(void)connectionDidFinishLoading:(CPURLConnection)connection
{
	sessionTable = JSON.parse(currentData);
	[tableView reloadData];
}

@end
