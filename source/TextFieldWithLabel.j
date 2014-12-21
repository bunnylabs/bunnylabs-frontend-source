@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation TextFieldWithLabel : CPView
{
	CPTextField textField;
	CPTextField label;

	id target @accessors;
	SEL validator @accessors;
}

-(id)initWithLabel:(CPString)aLabel andPlaceHolder:(CPString)aPlaceholder andWidth:(CPInteger)aWidth
{
	return [self initWithLabel:aLabel andPlaceHolder:aPlaceholder andWidth:aWidth isSecure:NO];
}

-(id)initWithLabel:(CPString)aLabel andPlaceHolder:(CPString)aPlaceholder andWidth:(CPInteger)aWidth isSecure:(BOOL)secure
{
	self = [super init];
	if (self)
	{
		textField = [CPTextField textFieldWithStringValue:"" placeholder:aPlaceholder width:aWidth - 125];
		[textField setDelegate:self];
		[textField setSecure:secure];
		[textField setFrameOrigin:CGPointMake(125,0)];
		[self addSubview:textField];

		label = [CPTextField labelWithTitle:aLabel];
		[label setFrame:CGRectMake(0,0,120, [textField bounds].size.height)];
		[label setVerticalAlignment: CPCenterVerticalTextAlignment];
		[label setAlignment:CPRightTextAlignment];
		[self addSubview:label];

		[self setFrame:CGRectMake(0,0,aWidth,[textField bounds].size.height)];
	}

	return self;
}

-(void)controlTextDidFocus:(CPTextField)aTextField
{
}

-(void)controlTextDidBlur:(CPTextField)aTextField
{
}

-(void)controlTextDidBeginEditing:(CPTextField)aTextField
{
}

-(void)controlTextDidChange:(CPTextField)aTextField
{
	[self validate];
}

-(BOOL)validate
{
	if ([target respondsToSelector:validator])
	{
		var valid = [target performSelector:validator withObject:[textField stringValue]];
		if (!valid)
		{
			[textField setBackgroundColor:[CPColor redColor]];
		}
		else
		{
			[textField setBackgroundColor:[CPColor clearColor]];
		}
		return valid;
	}
	return true;
}

-(void)controlTextDidEndEditing:(CPTextField)aTextField
{
}

-(CPString)text
{
	return [textField stringValue];
}

-(void)setText:(CPString)aString
{
	[textField setStringValue:aString];
}


@end
