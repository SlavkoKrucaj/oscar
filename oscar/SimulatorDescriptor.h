#import <Foundation/Foundation.h>

@interface SimulatorDescriptor : NSObject
@property (nonatomic, readonly) CGDirectDisplayID displayId;
@property (nonatomic, readonly) CGRect windowFrame;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDisplayId:(CGDirectDisplayID)displayId windowFrame:(CGRect)windowFrame;
@end
