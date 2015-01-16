@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "ApplicationInfo.j"

@implementation IconView : CPView
{
    CPImageView _imageView;
    CPTextField _textField;
}

-(id)initWithCoder:(CPCoder)aCoder
{
	self = [super initWithCoder:aCoder];
	if (self)
	{
		_imageView = [[CPImageView alloc] initWithFrame:CGRectMake(25,5,100,100)];

		[_imageView setImageScaling:CPScaleProportionally];
		[self addSubview:_imageView];

		var textRect = CGRectMake(5,107,140,40);

		//var ss = [[CPView alloc] initWithFrame:textRect];
		//[ss setBackgroundColor:[CPColor whiteColor]];
		//[self addSubview:ss];

		_textField = [[CPTextField alloc] initWithFrame:textRect];
		[_textField setLineBreakMode:CPLineBreakByWordWrapping]; 
		[_textField setAlignment:CPCenterTextAlignment];
		[_textField setVerticalAlignment:CPCenterVerticalTextAlignment];
		[_textField setTextShadowColor:[CPColor whiteColor]];
		[_textField setTextShadowOffset:CGSizeMake(1,1)];

		var font = [CPFont boldFontWithName:"Helvetica" size:12];
		[_textField setFont:font];
		[_textField setTextColor:[CPColor blackColor]];

		[self addSubview:_textField];

	}
	return self;
}

-(void)setRepresentedObject:(ApplicationInfo)appInfo
{
	if (appInfo)
	{
		[_textField setStringValue:[appInfo name]];
		[_imageView setImage:[appInfo icon]];
	}
}

-(void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil];
}

@end
