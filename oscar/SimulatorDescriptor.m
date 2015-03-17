#import "SimulatorDescriptor.h"

@implementation SimulatorDescriptor

- (instancetype)initWithDisplayId:(CGDirectDisplayID)displayId windowFrame:(CGRect)windowFrame
{
    self = [super init];
    if (self) {
        _displayId = displayId;
        _windowFrame = windowFrame;
    }
    return self;
}

@end
