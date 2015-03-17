#import "Recorder.h"

@interface Recorder () <AVCaptureFileOutputRecordingDelegate>
@property(nonatomic, readonly) SimulatorDescriptor *sim;
@property(nonatomic, readonly) NSURL *fileUrl;

@property(nonatomic, strong) AVCaptureSession *captureSession;
@end

@implementation Recorder

#pragma mark - Initializer

- (instancetype)initWithSimulator:(SimulatorDescriptor *)sim
                         fileURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        NSParameterAssert(sim);
        NSParameterAssert(fileURL);
        _sim = sim;
        _fileUrl = fileURL;
    }
    return self;
}

#pragma mark - Public methods

- (void)startRecording
{
    AVCaptureScreenInput *input = [[AVCaptureScreenInput alloc] initWithDisplayID:self.sim.displayId];
    input.capturesMouseClicks = YES;
    CGRect displayBounds = CGDisplayBounds(self.sim.displayId);
    input.cropRect = CGRectMake(self.sim.windowFrame.origin.x - displayBounds.origin.x,
        displayBounds.size.height - displayBounds.origin.y - self.sim.windowFrame.origin.y - self.sim.windowFrame.size.height,
        self.sim.windowFrame.size.width,
        self.sim.windowFrame.size.height);

    AVCaptureMovieFileOutput *output = [[AVCaptureMovieFileOutput alloc] init];
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession startRunning];
    [self.captureSession addInput:input];
    [self.captureSession addOutput:output];

    [output startRecordingToOutputFileURL:self.fileUrl recordingDelegate:self];
}

- (void)stopRecording
{
    [self.captureSession stopRunning];
}

#pragma mark - Private

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
}


@end
