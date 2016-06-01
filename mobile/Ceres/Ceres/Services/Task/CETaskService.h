#import <Foundation/Foundation.h>

#import "CETask.h"

@protocol CETaskService <NSObject>

- (nonnull RACSignal *)tasksForCoordinate:(CLLocationCoordinate2D)coordinate;
- (nonnull RACSignal *)taskWithTaskId:(nonnull NSString *)taskId;
- (nonnull RACSignal *)applyToTaskWithTaskId:(nonnull NSString *)taskId;
- (nonnull RACSignal *)createTask:(nonnull CETask *)task;

@end
