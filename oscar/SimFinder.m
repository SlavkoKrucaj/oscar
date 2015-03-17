#import "SimFinder.h"
#import <AppKit/AppKit.h>

@implementation SimFinder

#pragma mark - Public

- (SimulatorDescriptor *)findSimulator
{
    NSArray *windowList = (__bridge NSArray*)CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
    for (NSDictionary *windowDict in windowList) {
        if ([self isSimulatorWindow:windowDict]) {
            [self bringToFront:windowDict];
            return [self createSimulatorDescriptor:windowDict];
        }
    }
    return nil;
}

#pragma mark - Private

- (void)bringToFront:(NSDictionary *)windowDict
{
    pid_t pid = [windowDict[(id)kCGWindowOwnerPID] unsignedIntValue];
    NSRunningApplication *application = [NSRunningApplication runningApplicationWithProcessIdentifier:pid];
    if (![application activateWithOptions:NSApplicationActivateIgnoringOtherApps]) {
        NSLog(@"failed to bring simulator to front");
        exit(1);
    }
}

- (BOOL)isSimulatorWindow:(NSDictionary *)windowDict
{
    return [windowDict[(id)kCGWindowOwnerName] isEqualToString:@"iOS Simulator"] &&
           [windowDict[(id)kCGWindowNumber] unsignedIntValue] != 0;
}

- (SimulatorDescriptor *)createSimulatorDescriptor:(NSDictionary *)windowDict
{
    CGRect simFrame;
    CGDirectDisplayID displayID = 0;
    NSDictionary *boundsDict = windowDict[(id)kCGWindowBounds];
    CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)boundsDict, &simFrame);
    CGGetDisplaysWithPoint(simFrame.origin, 1, &displayID, NULL);
    return [[SimulatorDescriptor alloc] initWithDisplayId:displayID windowFrame:simFrame];
}

@end
