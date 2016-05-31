#import "CETaskUseCase.h"

#import "CECreateTaskFormElementCellPresentable.h"

#import "CEDatePickerFormElement.h"
#import "CETextFieldFormElement.h"

@interface CETaskUseCase ()

@property (strong, nonatomic, nonnull) id <CETaskService> taskService;
@property (strong, nonatomic, nonnull) id <CEDeviceLocationService> deviceLocationService;

@end

@implementation CETaskUseCase

- (RACSignal *)presentFormElements
{
    return [RACSignal return:[self presentables]];
}

- (RACSignal *)presentNearbyTasks
{
    return [[[self.deviceLocationService currentDeviceLocation] flattenMap:^RACStream *(CLLocation *location) {
        return [self.taskService tasksForCoordinate:location.coordinate];
    }] map:^id(NSArray *tasks) {
        return tasks;
    }];
}

#pragma mark - Private

- (NSArray *)presentables
{
    CECreateTaskFormElementCellPresentable *descriptionPresentable = [CECreateTaskFormElementCellPresentable new];
    descriptionPresentable.formElementView = [CETextFieldFormElement new];
    descriptionPresentable.title = NSLocalizedString(@"Description", nil);
    
    CECreateTaskFormElementCellPresentable *startDatePresentable = [CECreateTaskFormElementCellPresentable new];
    startDatePresentable.formElementView = [CEDatePickerFormElement new];
    startDatePresentable.title = NSLocalizedString(@"Start date", nil);
    
    CECreateTaskFormElementCellPresentable *endDatePresentable = [CECreateTaskFormElementCellPresentable new];
    endDatePresentable.formElementView = [CEDatePickerFormElement new];
    endDatePresentable.title = NSLocalizedString(@"End date", nil);

    return @[descriptionPresentable, startDatePresentable, endDatePresentable];
}

#pragma mark - Properties

- (id<CETaskService>)taskService
{
    return [CEContext defaultContext].taskService;
}

- (id<CEDeviceLocationService>)deviceLocationService
{
    return [CEContext defaultContext].deviceLocationService;
}

@end
