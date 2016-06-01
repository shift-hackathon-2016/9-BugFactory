#import <Foundation/Foundation.h>

@interface CENotificationCellPresentable : NSObject

@property (strong, nonatomic, nonnull) NSString *title;
@property (strong, nonatomic, nonnull) NSString *descriptionObject;
@property (strong, nonatomic, nonnull) NSString *objectId;

+ (nonnull instancetype)presentableWithNotification:(nonnull CENotification *)notification;

@end
