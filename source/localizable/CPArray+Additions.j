@import <Foundation/Foundation.j>

@implementation CPArray (Additions)

-(id)last
{
	return [self objectAtIndex:[self count] - 1];
}

-(id)first
{
	return [self objectAtIndex:0];
}

-(CPArray)filterWithPredicate:(Function)predicate
{
	var i = 0, 
		newArray = [],
		currItem,
		count = [self count];

	for (i=0; i<count; i++)
	{
		currItem = [self objectAtIndex:i];
		if (predicate(currItem))
		{
			newArray.push(currItem);
		}
	}
	return newArray;
}

-(void)foreach:(Function)action
{
	var i = 0, 
		newArray = [],
		currItem,
		count = [self count];

	for (i=0; i<count; i++)
	{
		currItem = [self objectAtIndex:i];
		action(currItem);
	}
}

@end
