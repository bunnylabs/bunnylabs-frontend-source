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

@import "Utils/HashFragment.j"

@implementation AppController : CPObject
{
    CPMenu mainMenu;
    CPView contentView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
    contentView = [theWindow contentView];

    [theWindow setDelegate:self];
    [theWindow orderFront:self];

    [CPMenu setMenuBarVisible:YES];

    [self refreshMenu];
    [self setDesktop];

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

-(void)setDesktop
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
    [imageView setCenter:[contentView center]];

    [contentView addSubview:imageView];
}

-(void)refreshMenu
{
    mainMenu = [[CPApplication sharedApplication] mainMenu];

    while ([mainMenu countOfItems] > 0)
    {
        [mainMenu removeItemAtIndex:0];
    }

    [mainMenu removeAllItems];

    [mainMenu addItem:[CPMenuItem separatorItem]];
    [mainMenu addItem:[CPMenuItem separatorItem]];
    [mainMenu addItem:[[SessionManager instance] sessionStatusMenuItem]];
}

-(void)windowDidResize:(CPNotification)notification
{
    [[DesktopManager instance] desktopResized];
    [self refreshMenu];
}

@end
