#import <Foundation/Foundation.h>

@protocol CETaskService <NSObject>

- (nonnull RACSignal *)tasksForCoordinate:(CLLocationCoordinate2D)coordinate;

@end
