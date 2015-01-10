@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

var desktopInstance;

@implementation DesktopManager : CPObject
{
	CPView topWindow;
	CPView contentView;
	CPView topView;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		topWindow = [[CPApplication sharedApplication] mainWindow];
		contentView = [topWindow contentView];
	}
	return self;
}

-(void)desktopResized
{
	[[CPNotificationCenter defaultCenter] postNotificationName:"desktopresize" object:""];
}

-(void)setDefaultButton:(CPButton)aButton
{
	[topWindow setDefaultButton:aButton];
}

-(CPButton)defaultButton
{
	return [topWindow defaultButton];
}

-(void)setTopView:(CPView)aView
{
	while([contentView subviews].length != 0)
	{
		[[contentView subviews][0] removeFromSuperview];
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