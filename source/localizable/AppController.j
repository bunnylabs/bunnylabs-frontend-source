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

@import "ApplicationManager.j"
@import "AdminManager.j"

@import "BunnyLabsIconViewController.j"

@import "Utils/HashFragment.j"

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
    [[DesktopManager instance] pushTopViewController:[[BunnyLabsIconViewController alloc] init]];

    [[MenuManager instance] rightStack].push([[SessionManager instance] sessionStatusMenuItem]);

    [ApplicationManager instance];
    [AdminManager instance];

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
