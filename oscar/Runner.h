#import <Foundation/Foundation.h>
#import "SimFinder.h"

@interface Runner : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFileName:(NSString *)fileName;

- (void)run;

@end
