@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "SessionManager.j"
@import "BunnyTableView.j"

@implementation UserTableViewController : CPViewController
{
	BunnyTableView tableView;

	id userTable;

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

		[tableView addColumnNamed:"name"];
		[tableView addColumnNamed:"email"];
		[tableView addColumnNamed:"password"];
		[tableView addBooleanColumnNamed:"validated"];
		[tableView addColumnNamed:"validationToken"];
		[tableView addColumnNamed:"registrationTime"];
		[tableView addColumnNamed:"currentSession"];
		[tableView addColumnNamed:"accountType"];
		[tableView addColumnNamed:"githubAccessToken"];
		[tableView addColumnNamed:"identityId"];

		[self reloadData];
		[self setView:tableView];
	}
	return self;
}

-(void)reloadData
{
	[[SessionManager instance] get:"/admin/users" andNotify:self];
}

-(void)reloadButtonClicked:(id)sender
{
	[self reloadData];
}

-(int)numberOfRowsInTableView:(CPTableView)aTableView
{
	if (userTable)
	{
		return userTable.length;
	}
	return 0;
}

-(id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aColumn row:(int)aRowIndex
{
	return userTable[aRowIndex][ [aColumn identifier] ];
}

-(void)tableView:(CPTableView)aTableView setObjectValue:(id)anObject forTableColumn:(CPTableColumn)aTableColumn row:(int)rowIndex
{
	var value = anObject;
	if ([aTableColumn identifier] == "validated")
	{
		value = anObject ? true : false;
	}
	[[SessionManager instance] put:"/admin/users/" + userTable[rowIndex].identityId + "/" + [aTableColumn identifier] 
								withData:{ value:value } 
								andNotify:self];

}

-(BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)aTableColumn row:(int)rowIndex
{
	if ([aTableColumn identifier] == "name")
	{
		return NO;
	}
	return YES;
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
	if (currentData === "OK")
	{
		[self reloadData];
	}
	else
	{
		userTable = JSON.parse(currentData);
		[tableView reloadData];
	}
}

@end
