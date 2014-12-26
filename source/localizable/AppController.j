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



        var button = [CPButton buttonWithTitle:"login"];
        [button setTarget:self];
        [button setAction:@selector(login:)];
        [contentView addSubview:button];

        var cpbutton = [CPButton buttonWithTitle:"changepass"];
        [cpbutton setFrameOrigin:CGPointMake(0,20)];
        [cpbutton setTarget:self];
        [cpbutton setAction:@selector(changepass:)];
        [contentView addSubview:cpbutton];
    //[SessionManager instance] 
}

-(id)login:(id)sender
{
    [[SessionManager instance] showLoginWindow];
}

-(id)changepass:(id)sender
{
    [[SessionManager instance] showChangePasswordWindow];
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

    var loginStatusTextField = [CPTextField labelWithTitle:"Not Logged In"];

    var font = [CPFont fontWithName:"Helvetica" size:14];

    [loginStatusTextField setFrameOrigin:CGPointMake(0,6)];
    [loginStatusTextField setFont:font];
    [loginStatusTextField sizeToFit];

    var item = [[CPMenuItem alloc] init];
    [item setView:loginStatusTextField];
    [mainMenu addItem:[CPMenuItem separatorItem]];
    [mainMenu addItem:[CPMenuItem separatorItem]];
    [mainMenu addItem:item];
}

-(void)windowDidResize:(CPNotification)notification
{
    [self refreshMenu];
}

@end
