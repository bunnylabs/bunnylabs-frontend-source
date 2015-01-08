/*
 * AppController.j
 * BunnyLabs
 *
 * Created by You on November 22, 2014.
 * Copyright 2014, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

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


        var button = [CPButton buttonWithTitle:"test"];
        [button setTarget:self];
        [button setAction:@selector(test:)];
        [contentView addSubview:button];

        var ghlogin = [CPButton buttonWithTitle:"ghlogin"];
        [ghlogin setFrameOrigin:CGPointMake(0,80)];
        [ghlogin setTarget:self];
        [ghlogin setAction:@selector(ghlogin:)];
        [contentView addSubview:ghlogin];

        var cpbutton = [CPButton buttonWithTitle:"changepass"];
        [cpbutton setFrameOrigin:CGPointMake(0,20)];
        [cpbutton setTarget:self];
        [cpbutton setAction:@selector(changepass:)];
        [contentView addSubview:cpbutton];


        var ds = [CPButton buttonWithTitle:"dosomething"];
        [ds setFrameOrigin:CGPointMake(0,50)];
        [ds setTarget:self];
        [ds setAction:@selector(ds:)];
        [contentView addSubview:ds];
    //[SessionManager instance] 
}

-(id)test:(id)sender
{
    [[SessionManager instance] get:"/admin/usercount" andNotify:self];
}

-(id)ghlogin:(id)sender
{
    [[SessionManager instance] loginWithGithub];
}

-(id)changepass:(id)sender
{
    [[SessionManager instance] showChangePasswordWindow];
}

-(id)ds:(id)sender
{
    [[SessionManager instance] get:"/" andNotify:self];
}

-(void)performHash
{
    var hash = [HashFragment fragmentAsObject];
    if (hash.validate)
    {
        [[SessionManager instance] validateUser:hash.validateUsername withToken:hash.validate];
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
    [self refreshMenu];
}

@end
