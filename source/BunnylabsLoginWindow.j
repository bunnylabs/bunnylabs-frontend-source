@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "TextFieldWithLabel.j"

var LOGIN_STATE = 1;
var REGISTRATION_STATE = 2;
var FORGOTPASSWORD_STATE = 3;
var CHANGEPASSWORD_STATE = 4;

@implementation BunnylabsLoginWindow : CPPanel
{
	CPInteger currentState;

	CPView contentView;

	CPTextField messageField;
	CPTextField errorField;

	TextFieldWithLabel usernameField;
	TextFieldWithLabel passwordField;
	TextFieldWithLabel passwordConfirmField;
	TextFieldWithLabel emailField;

	CPButton loginButton;
	CPButton newAccountButton;
	CPButton forgotPasswordButton;
	CPButton registerButton;
	CPButton submitUsernameButton;
	CPButton cancelButton;
	CPButton changePasswordButton;

	int messageSize;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		contentView = [self contentView];
		[self setFrame:CGRectMake(0,0,100,100)];
		[self center];
		[self setFrameOrigin:CGPointMake([self frame].origin.x,[self frame].origin.y-50)];


		messageField = [[CPTextField alloc] initWithFrame:CGRectMake(0,0,100,40)];
		[messageField setLineBreakMode:CPLineBreakByWordWrapping];
		[messageField setBackgroundColor:[CPColor colorWithCalibratedRed:103.0 / 255.0 green:154.0 / 255.0 blue:205.0 / 255.0 alpha:1.0]];
		[messageField setTextColor:[CPColor whiteColor]];
		[messageField setAutoresizingMask: CPViewWidthSizable];
		[messageField setValue:CGInsetMake(9.0, 9.0, 9.0, 9.0) forThemeAttribute:@"content-inset"];
		[contentView addSubview:messageField];


		errorField = [[CPTextField alloc] initWithFrame:CGRectMake(0,0,100,0)];
		[errorField setLineBreakMode:CPLineBreakByWordWrapping];
		[errorField setBackgroundColor:[CPColor colorWithHexString:"993333"]];
		[errorField setTextColor:[CPColor whiteColor]];
		[errorField setAutoresizingMask: CPViewWidthSizable];
		[errorField setValue:CGInsetMake(9.0, 9.0, 9.0, 9.0) forThemeAttribute:@"content-inset"];
		[contentView addSubview:errorField];

		loginButton = [CPButton buttonWithTitle:"Log In"];
		[loginButton setFrame:CGRectMake(10,180,185,[loginButton bounds].size.height)];
		[contentView addSubview:loginButton];

		newAccountButton = [CPButton buttonWithTitle:"New Account"];
		[newAccountButton setFrame:CGRectMake(10,180,185,[newAccountButton bounds].size.height)];
		[newAccountButton setTarget:self];
		[newAccountButton setAction:@selector(newAccountButtonClicked:)];
		[contentView addSubview:newAccountButton];

		forgotPasswordButton = [CPButton buttonWithTitle:"Forgot Password"];
		[forgotPasswordButton setFrame:CGRectMake(10,180,185,[forgotPasswordButton bounds].size.height)];
		[forgotPasswordButton setTarget:self];
		[forgotPasswordButton setAction:@selector(forgotPasswordButtonClicked:)];
		[contentView addSubview:forgotPasswordButton];

		registerButton = [CPButton buttonWithTitle:"Register"];
		[registerButton setFrame:CGRectMake(10,180,185,[registerButton bounds].size.height)];
		[contentView addSubview:registerButton];

		changePasswordButton = [CPButton buttonWithTitle:"Change Password!"];
		[changePasswordButton setFrame:CGRectMake(10,180,185,[changePasswordButton bounds].size.height)];
		[contentView addSubview:changePasswordButton];

		submitUsernameButton = [CPButton buttonWithTitle:"Send Recovery E-mail"];
		[submitUsernameButton setFrame:CGRectMake(10,180,185,[submitUsernameButton bounds].size.height)];
		[contentView addSubview:submitUsernameButton];

		cancelButton = [CPButton buttonWithTitle:"Cancel"];
		[cancelButton setFrame:CGRectMake(205,180,185,[cancelButton bounds].size.height)];
		[cancelButton setTarget:self];
		[cancelButton setAction:@selector(cancelButtonClicked:)];
		[contentView addSubview:cancelButton];


		usernameField = [[TextFieldWithLabel alloc] initWithLabel:"Username:" 
													   andPlaceHolder:"Username" 
															 andWidth:380];
		[usernameField setFrameOrigin:CGPointMake(10,20)];
		[contentView addSubview:usernameField];

		passwordField = [[TextFieldWithLabel alloc] initWithLabel:"Password:" 
													   andPlaceHolder:"Password" 
															 andWidth:380 
															 isSecure:YES];
		[passwordField setFrameOrigin:CGPointMake(10,50)];
		[contentView addSubview:passwordField];

		passwordConfirmField = [[TextFieldWithLabel alloc] initWithLabel:"Password (again):" 
															  andPlaceHolder:"Re-type your password" 
																	andWidth:380 isSecure:YES];
		[passwordConfirmField setFrameOrigin:CGPointMake(10,80)];
		[contentView addSubview:passwordConfirmField];

		emailField = [[TextFieldWithLabel alloc] initWithLabel:"E-mail:" 
													andPlaceHolder:"E-mail" 
														  andWidth:380];
		[emailField setFrameOrigin:CGPointMake(10,110)];
		[contentView addSubview:emailField];

		messageSize = 0;

		[self setState:LOGIN_STATE];
	}
	return self;
}

-(id)cancelButtonClicked:(id)sender
{
	[self close];
	return sender;
}

-(id)newAccountButtonClicked:(id)sender
{
	[self setState:REGISTRATION_STATE];
	return sender;
}

-(id)forgotPasswordButtonClicked:(id)sender
{
	[self setState:FORGOTPASSWORD_STATE];
	return sender;
}

-(BOOL)usernameIsValid:(CPString)username
{
	if (username.length < 4)
	{
		[self setError: "Username must be at least 4 letters"];
		[self _update];
		return NO;
	}
	[self setError: ""];
	[self _update];
	return YES;
}

-(BOOL)passwordIsValid:(CPString)password
{
	if (password.length < 8)
	{
		[self setError: "Password must be at least 8 letters"];
		[self _update];
		return NO;
	}
	[self setError: ""];
	[self _update];
	return YES;
}

-(BOOL)passwordsMatch:(CPString)password
{
	if (password !== [passwordField text])
	{
		[self setError: "Passwords do not match"];
		[self _update];
		return NO;
	}
	[self setError: ""];
	[self _update];
	return YES;
}

-(BOOL)emailIsValid:(CPString)email
{
	var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		
	if (!re.test(email))
	{
		[self setError: "Please type in a valid e-mail address"];
		[self _update];
		return NO;
	}
	[self setError: ""];
	[self _update];
	return YES;
}

-(void)setMessage:(CPString)aMessage
{
	[messageField setStringValue:aMessage];
	[self _update];
}

-(void)setError:(CPString)anErrorMessage
{
	[errorField setStringValue:anErrorMessage];
	[self _update];
}

-(CPString)_getPasswordRules
{
	var rules = [
					"We don't care if you use symbols in your password",
					"You are responsible for your own account",
					"Try and make your password long",
					"Poems and lyrics are effective ways to have long passwords",
					"If its short people can guess it easily"
					];
	var ruleString = "";
	for (var i=0; i<rules.length; i++)
	{
		ruleString += "\n• " + rules[i];
	}
	return ruleString;
}

-(void)setState:(CPInteger)state
{
	currentState = state;

	[self setError:""];

	switch(currentState)
	{
		case LOGIN_STATE:
			[self setMessage:"Please enter your username and password"];
			break;

		case REGISTRATION_STATE:
			[self setMessage:"Account registration: A validation e-mail will be sent to you which contains a link you need to click before you can use your account.\n" + [self _getPasswordRules]];
			break;

		case FORGOTPASSWORD_STATE:
			[self setMessage:"Forgot your password? Fear not. Enter your username and e-mail here and a reset password link will be sent to your e-mail"];
			break;

		case CHANGEPASSWORD_STATE:
			[self setMessage:"Change your password to something memorable and long.\n" + [self _getPasswordRules]];
			break;
	}

	[self _update];
}

-(void)_update
{

	var targetWidth = [self frame].size.width;
	var targetHeight = [self frame].size.height;

	var messageFieldSize = {width: [messageField frame].size.width, height: 0};
	if ([messageField stringValue] && [messageField stringValue].length > 0)
	{
		messageFieldSize = [[messageField stringValue] sizeWithFont:[messageField font] inWidth:[messageField frame].size.width];
		[messageField setFrame:CGRectMake(0, 0, messageFieldSize.width, messageFieldSize.height + 18)];
	}
	else
	{
		[messageField setFrame:CGRectMake(0, 0, messageFieldSize.width, 0)];
	}

	var errorFieldSize = {width: [errorField frame].size.width, height: 0};
	if ([errorField stringValue] && [errorField stringValue].length > 0)
	{
		errorFieldSize = [[errorField stringValue] sizeWithFont:[errorField font] inWidth:[errorField frame].size.width];
		[errorField setFrame:CGRectMake(0, [messageField frame].size.height, errorFieldSize.width, errorFieldSize.height + 18)];
	}
	else
	{
		[errorField setFrame:CGRectMake(0, [messageField frame].size.height, errorFieldSize.width, 0)];
	}

	messageSize = [messageField frame].size.height + [errorField frame].size.height;

	switch(currentState)
	{
		case LOGIN_STATE:

			[self setTitle:"Log In"];

			[usernameField setHidden:NO];
			[passwordField setHidden:NO];
			[passwordConfirmField setHidden:YES];
			[emailField setHidden:YES];
			[registerButton setHidden:YES];
			[submitUsernameButton setHidden:YES];
			[newAccountButton setHidden:NO];
			[forgotPasswordButton setHidden:NO];
			[loginButton setHidden:NO];
			[changePasswordButton setHidden:YES];
			[cancelButton setHidden:NO];

			[usernameField setFrameOrigin:CGPointMake(10,10 + messageSize)];
			[passwordField setFrameOrigin:CGPointMake(10,40 + messageSize)];

			[loginButton setFrame:CGRectMake(10, 80 + messageSize,185, [loginButton bounds].size.height)];
			[cancelButton setFrame:CGRectMake(205, 80 + messageSize,185, [cancelButton bounds].size.height)];

			[newAccountButton setFrame:CGRectMake(10, 110 + messageSize,185, [loginButton bounds].size.height)];
			[forgotPasswordButton setFrame:CGRectMake(205, 110 + messageSize,185, [cancelButton bounds].size.height)];

			[usernameField setTarget:nil];
			[passwordField setTarget:nil];
			[passwordConfirmField setTarget:nil];
			[emailField setTarget:nil];

			[self setDefaultButton: loginButton];

			targetWidth = 400;
			targetHeight = 180 + messageSize;

			break;

		case REGISTRATION_STATE:

			[self setTitle:"Register"];

			[usernameField setHidden:NO];
			[passwordField setHidden:NO];
			[passwordConfirmField setHidden:NO];
			[emailField setHidden:NO];
			[registerButton setHidden:NO];
			[submitUsernameButton setHidden:YES];
			[newAccountButton setHidden:YES];
			[forgotPasswordButton setHidden:YES];
			[loginButton setHidden:YES];
			[changePasswordButton setHidden:YES];
			[cancelButton setHidden:NO];

			[usernameField setFrameOrigin:CGPointMake(10,10 + messageSize)];
			[passwordField setFrameOrigin:CGPointMake(10,40 + messageSize)];

			[passwordConfirmField setFrameOrigin:CGPointMake(10,70 + messageSize)];
			[emailField setFrameOrigin:CGPointMake(10,100 + messageSize)];

			[registerButton setFrame:CGRectMake(10, 140 + messageSize,185, [loginButton bounds].size.height)];
			[cancelButton setFrame:CGRectMake(205, 140 + messageSize,185, [cancelButton bounds].size.height)];

			[self setDefaultButton: registerButton];

			[usernameField setTarget:self];
			[usernameField setValidator:@selector(usernameIsValid:)];

			[passwordField setTarget:self];
			[passwordField setValidator:@selector(passwordIsValid:)];

			[passwordConfirmField setTarget:self];
			[passwordConfirmField setValidator:@selector(passwordsMatch:)];

			[emailField setTarget:self];
			[emailField setValidator:@selector(emailIsValid:)];

			targetWidth = 400;
			targetHeight = 210 + messageSize;

			break;

		case FORGOTPASSWORD_STATE:

			[self setTitle:"Forgot Password"];

			[usernameField setHidden:NO];
			[passwordField setHidden:YES];
			[passwordConfirmField setHidden:YES];
			[emailField setHidden:NO];
			[registerButton setHidden:YES];
			[submitUsernameButton setHidden:NO];
			[newAccountButton setHidden:YES];
			[forgotPasswordButton setHidden:YES];
			[loginButton setHidden:YES];
			[changePasswordButton setHidden:YES];
			[cancelButton setHidden:NO];

			[usernameField setFrameOrigin:CGPointMake(10,10 + messageSize)];
			[emailField setFrameOrigin:CGPointMake(10,40 + messageSize)];

			[submitUsernameButton setFrame:CGRectMake(10, 80 + messageSize,185, [loginButton bounds].size.height)];
			[cancelButton setFrame:CGRectMake(205, 80 + messageSize,185, [cancelButton bounds].size.height)];

			[self setDefaultButton: submitUsernameButton];

			[usernameField setTarget:nil];
			[passwordField setTarget:nil];
			[passwordConfirmField setTarget:nil];
			[emailField setTarget:nil];

			targetWidth = 400;
			targetHeight = 150 + messageSize;

			break;

		case CHANGEPASSWORD_STATE:

			[self setTitle:"Change Password"];

			[usernameField setHidden:YES];
			[passwordField setHidden:NO];
			[passwordConfirmField setHidden:NO];
			[emailField setHidden:YES];
			[registerButton setHidden:YES];
			[submitUsernameButton setHidden:YES];
			[newAccountButton setHidden:YES];
			[forgotPasswordButton setHidden:YES];
			[loginButton setHidden:YES];
			[changePasswordButton setHidden:NO];
			[cancelButton setHidden:NO];

			[passwordField setFrameOrigin:CGPointMake(10,10 + messageSize)];
			[passwordConfirmField setFrameOrigin:CGPointMake(10,40 + messageSize)];

			[changePasswordButton setFrame:CGRectMake(10, 80 + messageSize,185, [loginButton bounds].size.height)];
			[cancelButton setFrame:CGRectMake(205, 80 + messageSize,185, [cancelButton bounds].size.height)];

			[self setDefaultButton: changePasswordButton];

			[usernameField setTarget:nil];

			[passwordField setTarget:self];
			[passwordField setValidator:@selector(passwordIsValid:)];

			[passwordConfirmField setTarget:self];
			[passwordConfirmField setValidator:@selector(passwordsMatch:)];

			[emailField setTarget:nil];

			targetWidth = 400;
			targetHeight = 150 + messageSize;

			break;
	}

	var xmargins = (targetWidth - [self frame].size.width) / 2;
	var ymargins = (targetHeight - [self frame].size.height) / 2;

	[self setFrame:CGRectMake([self frame].origin.x - xmargins, [self frame].origin.y - ymargins, targetWidth, targetHeight) 
			display:YES 
			animate:YES];
}

-(CPInteger)state
{
	return currentState;
}

+(CPInteger)loginState
{
	return LOGIN_STATE;
}

+(CPInteger)registrationState
{
	return REGISTRATION_STATE;
}

+(CPInteger)forgotPasswordState
{
	return FORGOTPASSWORD_STATE;
}

+(CPInteger)changePasswordState
{
	return CHANGEPASSWORD_STATE;
}

@end
