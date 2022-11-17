#import "Test.h"

#import "stdio.h"
#import "stdlib.h"

void try_catch_in_objc(void);
void try_catch_in_objcxx(void);

void rethrow_objc(id ex) {
  @throw ex;
}

int main(void)
{
  printf("try_catch_in_objc\n");
  int count1 = [Test instances];
  printf("Count before = %d\n", count1);

  @try {
    printf("ObjC @try\n");
    try_catch_in_objc();
    exit(1); // unreachable
  } @catch (Test *localException) {
    printf("ObjC @catch, %p\n", localException);
  }

  int count2 = [Test instances];
  printf("Count after = %d\n", count2);

  printf("=======================\n");
  printf("try_catch_in_objcxx\n");
  printf("Count before = %d\n", count2);

  try_catch_in_objcxx();

  int count3 = [Test instances];
  printf("Count after = %d\n", count3);
}
