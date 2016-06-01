#import "CENotificationCellPresentable.h"

@implementation CENotificationCellPresentable

+ (instancetype)presentableWithNotification:(CENotification *)notification
{
    CENotificationCellPresentable *presentable = [CENotificationCellPresentable new];
    
    presentable.title = @"New lead";
    presentable.descriptionObject = @"Description";
    presentable.objectId = notification.objectId;
    
    return presentable;
}

@end
