#import "CENotificationsUseCase.h"

#import "CENotificationCellPresentable.h"

@interface CENotificationsUseCase ()

@property (strong, nonatomic, nonnull) id <CENotificationService> notificationService;

@end

@implementation CENotificationsUseCase

- (RACSignal *)presentNotifications
{
    return [[self.notificationService userNotifications] map:^id(NSArray *notifications) {
        return [notifications map:^id(CENotification *notification) {
            return [CENotificationCellPresentable presentableWithNotification:notification];
        }];
    }];
}

#pragma mark - Properties

- (id<CENotificationService>)notificationService
{
    return [CEContext defaultContext].notificationService;
}

@end
