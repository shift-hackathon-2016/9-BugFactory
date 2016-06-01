#import <Foundation/Foundation.h>

@interface CETaskUseCase : NSObject

- (nonnull RACSignal *)presentFormElements;
- (nonnull RACSignal *)presentNearbyTasks;
- (nonnull RACSignal *)presentTaskWithTaskId:(nonnull NSString *)taskId;

@end
