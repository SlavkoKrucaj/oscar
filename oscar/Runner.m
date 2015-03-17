#import "Runner.h"

#import <AppKit/AppKit.h>

#import "Recorder.h"

@interface Runner ()
@property (nonatomic, readonly) SimFinder *simFinder;
@property (nonatomic, readonly) NSURL *fileURL;
@end

@implementation Runner

#pragma mark - Initialization

- (instancetype)initWithFileName:(NSString *)fileName
{
    return [self initWithSimFinder:[[SimFinder alloc] init] fileURL:[NSURL fileURLWithPath:fileName]];
}

- (instancetype)initWithSimFinder:(SimFinder *)simFinder fileURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        NSParameterAssert(simFinder);
        NSParameterAssert(fileURL);
        _simFinder = simFinder;
        _fileURL = fileURL;
    }
    return self;
}

#pragma mark - Public

- (void)run
{
    SimulatorDescriptor *sim = [self iPhoneSimulator];
    Recorder *recorder = [[Recorder alloc] initWithSimulator:sim fileURL:self.fileURL];
    [self recordUsingRecorder:recorder];
}

#pragma mark - Private

- (SimulatorDescriptor *)iPhoneSimulator
{
    SimulatorDescriptor *sim = nil;
    while(sim == nil) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        sim = [self.simFinder findSimulator];
    }
    return sim;
}

- (void)recordUsingRecorder:(Recorder *)recorder
{
    [recorder startRecording];

    [self waitForSimToDie];

    [recorder stopRecording];
    sleep(1);
}

- (void)waitForSimToDie
{
    while (true) {
        NSArray *appList = [[NSWorkspace sharedWorkspace] runningApplications];
        if ([[appList valueForKey:@"localizedName"] containsObject:@"iOS Simulator"]) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        } else {
            return;
        }
    }
}

@end
