@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation BunnyLabsIconViewController : CPViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        var bundle = [CPBundle mainBundle];
        var file = [bundle pathForResource:@"Images/bunnylabs.png"];

        var image = [[CPImage alloc] initWithContentsOfFile:file];

        var imageView = [[CPImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];

        [imageView setImage:image];
        [imageView setAutoresizingMask: CPViewMinXMargin |
                                        CPViewMaxXMargin |
                                        CPViewMinYMargin |
                                        CPViewMaxYMargin];

        [self setView:imageView];
    }
    return self;
}

-(CPString)breadcrumbName
{
    return "Desktop"
}

@end
