@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation ToolBoxView : CPView
{
	CPTabView tableView;
	CPArray elements;

	CPBundle bundle;
}

-(id)init
{
	self = [super initWithFrame:CGRectMake(0,0,0,20)];
	if (self)
	{
		bundle = [CPBundle bundleWithIdentifier:"net.astrobunny.bunnylabs.DesignerApp"];

		tableView = [[CPTableView alloc] initWithFrame:CGRectMake(0,20,0,0)];

		var iconColumn = [[CPTableColumn alloc] initWithIdentifier:"icons"];
		[iconColumn setMaxWidth:25];
		[iconColumn setMinWidth:25];
		var iconView = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
		[iconView setImageAlignment:CPImageAlignCenter];
		[iconView setImageScaling:CPScaleNone];
		[iconColumn setDataView:iconView];
		[tableView addTableColumn:iconColumn];

		[tableView addTableColumn:[[CPTableColumn alloc] initWithIdentifier:"itemname"]];

        [tableView setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
		elements = ["CPView", "CPTableView", "CPSplitView", "CPButton"];

		[tableView setDataSource:self];
		[tableView reloadData];

		[self addSubview:tableView];
	}
	return self;
}

- (int)numberOfRowsInTableView:(CPTableView)aTableView
{
	return elements.length;
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aColumn row:(CPInteger)aRowIndex
{
	if ([aColumn identifier] === "itemname")
	{
		return elements[aRowIndex];
	}

	var file = [bundle pathForResource:"Images/" + elements[aRowIndex] + ".png"];

	return [[CPImage alloc] initWithContentsOfFile:file];
}

@end
