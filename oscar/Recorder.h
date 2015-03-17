#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SimulatorDescriptor.h"

@interface Recorder : NSObject

- (instancetype)initWithSimulator:(SimulatorDescriptor *)simulatorDescriptor fileURL:(NSURL *)url;

- (void)startRecording;
- (void)stopRecording;
@end
