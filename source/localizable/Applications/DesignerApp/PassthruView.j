@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation PassthruView : CPView

-(CPView)hitTest:(CGPoint)aPoint
{
    for (var i=0; i<[[self subviews] count]; i++)
    {
    	var subView = [[self subviews] objectAtIndex:i];
        if (![subView isHidden] && [subView hitTest:aPoint])
        {
            return subView;
        }
    }

    return nil;
}

@end

@implementation PassthruTextField : CPTextField


-(CPView)hitTest:(CGPoint)aPoint
{
    for (var i=0; i<[[self subviews] count]; i++)
    {
    	var subView = [[self subviews] objectAtIndex:i];
        if (![subView isHidden] && [subView hitTest:aPoint])
        {
            return subView;
        }
    }

    return nil;
}

@end