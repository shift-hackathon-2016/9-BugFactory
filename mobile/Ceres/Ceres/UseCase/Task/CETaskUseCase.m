#import "CETaskUseCase.h"

#import "CECreateTaskFormElementCellPresentable.h"

#import "CEDatePickerFormElement.h"
#import "CETextFieldFormElement.h"

#import "CETaskMapPinPresentable.h"
#import "CETaskPresentable.h"

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
        return [tasks map:^id(CETask *task) {
            return [CETaskMapPinPresentable presentableWithTask:task];
        }];
    }];
}

- (RACSignal *)presentTaskWithTaskId:(NSString *)taskId
{
    return [[self.taskService taskWithTaskId:taskId] map:^id(CETask *task) {
        return [CETaskPresentable presentableWithTask:task];
    }];
}

- (RACSignal *)applyToTaskWithTaskId:(NSString *)taskId
{
    return [[self.taskService applyToTaskWithTaskId:taskId] map:^id(id value) {
        return nil;
    }];
}

- (RACSignal *)createTask
{
    return [[self.taskService createTask:[self submitableTask]] map:^id(id value) {
        return nil;
    }];
}

- (CETask *)submitableTask
{
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [CETask new];
    });
    
    return instance;
}

#pragma mark - Private

- (NSArray *)presentables
{
    CECreateTaskFormElementCellPresentable *descriptionPresentable = [CECreateTaskFormElementCellPresentable new];
    CETextFieldFormElement *descriptionView = [CETextFieldFormElement new];
    descriptionPresentable.formElementView = descriptionView;
    RAC(descriptionPresentable, formValue) = [[descriptionView valueChanged] takeUntil:descriptionPresentable.rac_willDeallocSignal];
    
    descriptionPresentable.title = NSLocalizedString(@"Description", nil);
    descriptionPresentable.formElementType = CEFormElementTypeDescription;
    
    CECreateTaskFormElementCellPresentable *startDatePresentable = [CECreateTaskFormElementCellPresentable new];
    CEDatePickerFormElement *startDateView = [CEDatePickerFormElement new];
    startDatePresentable.formElementView = startDateView;
    RAC(startDatePresentable, formValue) = [[startDateView valueChanged] takeUntil:startDatePresentable.rac_willDeallocSignal];

    startDatePresentable.title = NSLocalizedString(@"Start date", nil);
    startDatePresentable.formElementType = CEFormElementTypeStartDate;
    
    CECreateTaskFormElementCellPresentable *endDatePresentable = [CECreateTaskFormElementCellPresentable new];
    
    CEDatePickerFormElement *endDateView = [CEDatePickerFormElement new];
    endDatePresentable.formElementView = endDateView;
    RAC(endDatePresentable, formValue) = [[endDateView valueChanged] takeUntil:endDatePresentable.rac_willDeallocSignal];
    
    endDatePresentable.title = NSLocalizedString(@"End date", nil);
    endDatePresentable.formElementType = CEFormElementTypeEndDate;
    
    return @[descriptionPresentable, startDatePresentable];
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
