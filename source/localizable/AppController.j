/*
 * AppController.j
 * BunnyLabs
 *
 * Created by You on November 22, 2014.
 * Copyright 2014, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "DesktopManager.j"
@import "SessionManager.j"
@import "MenuManager.j"

@import "Utils/HashFragment.j"

@implementation BunnyLabsIcon : CPViewController

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

@end

@implementation AppController : CPObject
{
    CPView contentView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
    contentView = [theWindow contentView];

    [theWindow setDelegate:self];
    [theWindow orderFront:self];

    [CPMenu setMenuBarVisible:YES];
    [[DesktopManager instance] pushTopViewController:[[BunnyLabsIcon alloc] init]];

    [[MenuManager instance] rightStack].push([[SessionManager instance] sessionStatusMenuItem]);

    [self performHash];
}

-(void)performHash
{
    var hash = [HashFragment fragmentAsObject];
    if (hash.validate)
    {
        [[SessionManager instance] validateUser:hash.validateUsername withToken:hash.validate];
    }
    if (hash.forgotPassword)
    {
        [[SessionManager instance] showChangePasswordWindow];
    }
}

-(void)windowDidResize:(CPNotification)notification
{
    [[DesktopManager instance] desktopResized];
}

@end
