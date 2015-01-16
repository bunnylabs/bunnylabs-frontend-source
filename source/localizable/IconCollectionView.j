@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "ApplicationInfo.j"
@import "IconView.j"

@implementation IconCollectionView : CPCollectionView
{

}

-(void)_prepare
{
    [self setMinItemSize:CGSizeMake(150, 150)];
    [self setMaxItemSize:CGSizeMake(150, 150)];

    var itemPrototype = [[CPCollectionViewItem alloc] init],
        iconView = [[IconView alloc] initWithFrame:CGRectMakeZero()];

    [itemPrototype setView:iconView];

    [self setItemPrototype:itemPrototype];

}

-(id)init
{
	self = [super init];
	if (self)
	{
		[self _prepare];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	{
		[self _prepare];
	}
	return self;
}

@end
