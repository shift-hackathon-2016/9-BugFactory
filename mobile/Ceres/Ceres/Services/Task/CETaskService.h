#import <Foundation/Foundation.h>

@protocol CETaskService <NSObject>

- (nonnull RACSignal *)tasksForCoordinate:(CLLocationCoordinate2D)coordinate;
- (nonnull RACSignal *)taskWithTaskId:(nonnull NSString *)taskId;
- (nonnull RACSignal *)applyToTaskWithTaskId:(nonnull NSString *)taskId;
- (nonnull RACSignal *)createTask:(nonnull NSString *)taskId;

@end
