#include <stdio.h>
#import "objc/runtime.h"

#if __has_attribute(objc_root_class)
__attribute__((objc_root_class))
#endif
@interface TestObj { id isa; }
+ (Class)class;
+ (id)testObj;
+ (const char *)testStr;
+ (int)testNum;
@end

@implementation TestObj
+ (Class)class {
	return self;
}
+ (id)testObj {
	id testObj = @"Test";
	printf("returning testObj: 0x%p\n", testObj);
	return testObj;
}
+ (const char *)testStr {
	return "forty two";
}
+ (int)testNum {
	return 42;
}
@end

int main() {
	id testClass = [TestObj class];
	printf("testClass: %s (%p)\n", class_getName(testClass), testClass);
	TestObj *testObj = [TestObj testObj];
	printf("testObj: 0x%p\n", testObj);
	const char *testStr = [TestObj testStr];
	printf("testStr: %s\n", testStr);
	int testNum = [TestObj testNum];
	printf("testNum: %d\n", testNum);

	if (testObj) {
		return 0;
	} else {
		return 1;
	}
}
