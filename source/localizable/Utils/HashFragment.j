@import <Foundation/Foundation.j>
@import "URLQueryString.j"

@implementation HashFragment : CPObject

+(CPString)fragment
{
    return window.location.hash;
}

+(id)fragmentAsObject
{
    return [URLQueryString deserialize:window.location.hash.substring(1)];
}

+(void)clearFragment
{
	window.location.hash = "";
}

@end
