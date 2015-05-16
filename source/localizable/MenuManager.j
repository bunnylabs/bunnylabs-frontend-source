@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "CPArray+Additions.j"

var menuManagerInstance;

@implementation MenuManager : CPObject
{
	CPArray leftStack;
	CPArray centerStack;
	CPArray rightStack;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		leftStack = [CPArray array];
		centerStack = [CPArray array];
		rightStack = [CPArray array];
	}
	return self;
}

-(CPArray)leftStack
{
	return leftStack;
}

-(CPArray)centerStack
{
	return centerStack;
}

-(CPArray)rightStack
{
	return rightStack;
}

+(MenuManager)instance
{
	if (!menuManagerInstance)
	{
		menuManagerInstance = [[MenuManager alloc] init];
	}
	return menuManagerInstance;
}

-(void)refreshMenu
{
    var mainMenu = [[CPApplication sharedApplication] mainMenu];

    while ([mainMenu countOfItems] > 0)
    {
        [mainMenu removeItemAtIndex:0];
    }

    [mainMenu removeAllItems];

    function addItem(menuItem)
    {
    	[mainMenu addItem:menuItem];
    }

    [leftStack foreach:addItem];
    [centerStack foreach:addItem];
    [mainMenu addItem:[CPMenuItem separatorItem]];
    [rightStack foreach:addItem];
}

@end
