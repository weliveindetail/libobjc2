#import "Test.h"
#import "stdio.h"
#import "stdlib.h"

extern "C" void rethrow_objc(id);
void rethrow_objcxx(id);

extern "C" void try_catch_in_objc(void)
{
    @try {
      printf("Raising Test exception\n");
      Test *ex = [Test new];
      @throw ex;
    } @catch (Test *localException) {
      printf("Caught - re-raising\n");
      rethrow_objc(localException);
    }
}

void doTryCatchRethrow()
{
    @try {
      printf("Raising Test exception\n");
      Test *ex = [Test new];
      @throw ex;
    } @catch (Test *localException) {
      printf("Caught - re-raising\n");
      rethrow_objcxx(localException);
    }
}

extern "C" void try_catch_in_objcxx(void)
{
    @try {
      printf("ObjC++ @try\n");
      doTryCatchRethrow();
      exit(1); // unreachable
    } @catch (Test *localException) {
      printf("ObjC++ @catch, %p\n", localException);
    }
}
