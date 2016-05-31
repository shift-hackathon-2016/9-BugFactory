#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CENavigationType) {
    CENavigationTypePush,
    CENavigationTypeModal
};

@protocol CENavigationService <NSObject>

- (void)openURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params completion:(void(^_Nullable)(UIViewController * _Nullable viewController, NSError * _Nullable))completion;
- (void)openURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params navigationType:(CENavigationType)navigationType completion:(void(^_Nullable)(UIViewController * _Nullable viewController, NSError * _Nullable))completion;
- (void)openRoute:(nonnull NSString *)route params:(nullable NSDictionary *)params completion:(void(^_Nullable)(UIViewController * _Nullable viewController, NSError * _Nullable))completion;
- (void)openRoute:(nonnull NSString *)route params:(nullable NSDictionary *)params navigationType:(CENavigationType)navigationType completion:(void(^_Nullable)(UIViewController * _Nullable viewController, NSError * _Nullable))completion;

@end
