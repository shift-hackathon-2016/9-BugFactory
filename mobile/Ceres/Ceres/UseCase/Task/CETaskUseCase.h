#import <Foundation/Foundation.h>

@interface CETaskUseCase : NSObject

+ (CETask *)submitTask;

- (nonnull RACSignal *)presentFormElements;
- (nonnull RACSignal *)presentNearbyTasks;
- (nonnull RACSignal *)presentTaskWithTaskId:(nonnull NSString *)taskId;
- (nonnull RACSignal *)applyToTaskWithTaskId:(nonnull NSString *)taskId;

@end
