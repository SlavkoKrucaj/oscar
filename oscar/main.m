#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Runner.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *arguments = [[NSProcessInfo processInfo] arguments];
        if (arguments.count == 2) {
            [[[Runner alloc] initWithFileName:[arguments lastObject]] run];
        } else {
            NSLog(@"you have to pass the file name with .mov extension");
        }
    }
    return 0;
}
