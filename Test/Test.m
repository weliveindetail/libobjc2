#import "../objc/runtime.h"
#import "../objc/objc-arc.h"
#ifdef NDEBUG
#undef NDEBUG
#endif
#include <assert.h>
#include <stdio.h>
#include "Test.h"

@implementation NSConstantString
- (void)dealloc
{
	// Silence a warning
	if (0)
	{
		[super dealloc];
	}
}
@end

@interface NSTinyString : NSConstantString @end
@implementation NSTinyString
+ (void)load
{
	if (sizeof(void*) > 4)
	{
		objc_registerSmallObjectClass_np(self, 4);
	}
}
- (Class)class { return [NSTinyString class]; }
- (id)retain { return self; }
- (id)autorelease { return self; }
- (void)release {}
@end

@implementation Test
static int Instances;
+ (int)instances
{
    return Instances;
}
+ (Class)class { return self; }
+ (id)new
{
	Instances += 1;
	printf("Create instance\n");
	return class_createInstance(self, 0);
}
- (void)dealloc
{
	object_dispose(self);
	printf("Destroy instance\n");
	Instances -= 1;
}
- (id)autorelease
{
	return objc_autorelease(self);
}
- (id)retain
{
	return objc_retain(self);
}
- (void)release
{
	objc_release(self);
}
- (void)_ARCCompliantRetainRelease {}
@end

@implementation NSAutoreleasePool
- (void)_ARCCompatibleAutoreleasePool {}
+ (void)addObject:(id)anObject
{
	objc_autorelease(anObject);
}
@end
