/*
 * AppController.j
 * BunnyLabs
 *
 * Created by You on November 22, 2014.
 * Copyright 2014, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation AppController : CPObject
{
    CPMenu mainMenu;
    CPTextField loginStatusTextField;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    mainMenu = [[CPApplication sharedApplication] mainMenu];
    [mainMenu removeAllItems];
    

    loginStatusTextField = [CPTextField labelWithTitle:"Not Logged In"];

    var font = [CPFont fontWithName:"Helvetica" size:14];

    [loginStatusTextField setFrameOrigin:CGPointMake(0,6)];
    [loginStatusTextField setFont:font];
    [loginStatusTextField sizeToFit];

    var item = [[CPMenuItem alloc] init];
    [item setView:loginStatusTextField];
    [mainMenu addItem:[CPMenuItem separatorItem]];
    [mainMenu addItem:[CPMenuItem separatorItem]];
    [mainMenu addItem:item];

    [CPMenu setMenuBarVisible:YES];


    var bundle = [CPBundle mainBundle];
    var file = [bundle pathForResource:@"Images/bunnylabs.png"];

    var image = [[CPImage alloc] initWithContentsOfFile:file];

    var imageView = [[CPImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];

    [imageView setImage:image];
    [imageView setCenter:[contentView center]];

    [contentView addSubview:imageView];

    [theWindow orderFront:self];

}

@end
