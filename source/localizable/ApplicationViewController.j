@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "ApplicationView.j"

@implementation ApplicationViewController : CPViewController
{
	CPArray menuData;

	ApplicationView view;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		view = [[ApplicationView alloc] init]
		[[view iconsView] setDelegate:self];
		[self setView:view];
	}
	return self;
}

-(BOOL)viewFillsDesktop
{
    return YES;
}

- (void)collectionView:(CPCollectionView)collectionView didDoubleClickOnItemAtIndex:(int)index
{
}
@end
