#import <Foundation/Foundation.h>

@interface CETaskUseCase : NSObject

- (nonnull CETask *)submitableTask;

- (nonnull RACSignal *)presentFormElements;
- (nonnull RACSignal *)presentNearbyTasks;
- (nonnull RACSignal *)presentTaskWithTaskId:(nonnull NSString *)taskId;
- (nonnull RACSignal *)applyToTaskWithTaskId:(nonnull NSString *)taskId;
- (nonnull RACSignal *)createTask;

@end
