#import "CENetworkTaskService.h"

#import "CETask+CEJSONMappable.h"

@implementation CENetworkTaskService

- (RACSignal *)tasksForCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSDictionary *parameters = @{
                                 @"latitude":@(coordinate.latitude),
                                 @"longitude":@(coordinate.longitude)
                                 };
    
    return [[self.APIClient GET:@"tasks/nearby" parameters:parameters] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        NSArray *JSON = tuple.second;
        return [JSON map:^id(NSDictionary *taskJSON) {
            return [CETask objectWithJSON:taskJSON error:errorPtr];
        }];
    }];
}

- (RACSignal *)taskWithTaskId:(NSString *)taskId
{
    NSString *path = [NSString stringWithFormat:@"tasks/%@", taskId];
    
    return [[self.APIClient GET:path parameters:nil] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        NSDictionary *JSON = tuple.second;
        
        return [CETask objectWithJSON:JSON error:errorPtr];
    }];
}

- (RACSignal *)applyToTaskWithTaskId:(NSString *)taskId
{
    NSDictionary *parameters = @{
                                 @"task_id": taskId
                                 };
    return [[self.APIClient POST:@"task-applications" parameters:parameters] map:^id(id value) {
        return nil;
    }];
}

- (RACSignal *)createTask:(CETask *)task
{
    NSDictionary *parameters = @{
                                 @"description": task.descriptionObject,
                                 @"location": @{
                                         @"latitude":task.location.latitude,
                                         @"longitude":task.location.longitude
                                         },
                                 @"starts_at":@(task.startsAt.timeIntervalSince1970),
                                 @"ends_at":@(task.endsAt.timeIntervalSince1970)
                                 };
    
    return [[self.APIClient POST:@"tasks" parameters:parameters] map:^id(id value) {
        return nil;
    }];
}

@end
