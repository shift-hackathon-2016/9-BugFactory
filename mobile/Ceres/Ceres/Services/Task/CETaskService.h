#import <Foundation/Foundation.h>

@protocol CETaskService <NSObject>

- (nonnull RACSignal *)tasksForCoordinate:(CLLocationCoordinate2D)coordinate;
- (nonnull RACSignal *)taskWithTaskId:(nonnull NSString *)taskId;

@end
