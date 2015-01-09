@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

var desktopInstance;

@implementation DesktopManager : CPObject
{
	CPView contentView @accessors;
	CPView topView;
}

-(id)init
{
	self = [super init];
	if (self)
	{

	}
	return self;
}

-(void)desktopResized
{

}

-(void)setTopView:(CPView)aView
{
	while([contentView subViews].length != 0)
	{
		[[contentView subViews][0] removeFromSuperview];
	}

	[contentView addSubview:aView];
	[aView setCenter:[contentView center]];
	[aView setAutoresizingMask: CPViewMinXMargin |
                            	CPViewMaxXMargin |
                            	CPViewMinYMargin |
                            	CPViewMaxYMargin];
}

+(DesktopManager)instance
{
	if (!desktopInstance)
	{
		desktopInstance = [[DesktopManager alloc] init];
	}
	return desktopInstance;
}

@end