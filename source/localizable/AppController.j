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


@implementation MyWebView : CPView
{
    id _iframe;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _iframe = document.createElement("iframe");
        _iframe.name = "iframe_" + FLOOR(RAND() * 10000);
        _iframe.style.width = "100%";
        _iframe.style.height = "100%";
        _iframe.style.borderWidth = "0px";
        _iframe.frameBorder = "0";

        _DOMElement.appendChild(_iframe)
    }
    return self;
}

-(void)setMainFrameURL:(CPString)aUrl
{
    _iframe.src = aUrl;
}

@end

@implementation BlogViewController : CPViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        var view = [[MyWebView alloc] initWithFrame:CGRectMake(0,0,100,100)];
        [view setMainFrameURL:"https://blog.davidsiaw.net"];
        [view setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];

        [self setView:view];
    }
    return self;
}

-(BOOL)viewFillsDesktop
{
    return YES;
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
