#import "CELocalNavigationService.h"
#import <objc/runtime.h>
#import <SafariServices/SafariServices.h>
#import "CERoutable.h"

#import "CEHomeViewController.h"
#import "CECreateTaskMapViewController.h"

static NSString * const kRouteParamPrefix = @":";

@interface CELocalNavigationService ()

@property (strong, nonatomic, nonnull) id <CENavigationProvider> navigationProvider;

@end

@implementation CELocalNavigationService

- (nonnull NSDictionary <NSString *, id> *)routesMap
{
    return @{
             @"home":[CEHomeViewController class],
             @"task/map":[CECreateTaskMapViewController class]
             };
}

- (void)openURL:(NSURL *)URL params:(NSDictionary *)params completion:(void (^)(UIViewController * _Nullable, NSError * _Nullable))completion
{
    [self openURL:URL params:params navigationType:CENavigationTypePush completion:completion];
}

- (void)openURL:(NSURL *)URL params:(NSDictionary *)params navigationType:(CENavigationType)navigationType completion:(void (^)(UIViewController * _Nullable, NSError * _Nullable))completion
{
    //if url begins with http(s)
    if ([URL.scheme.lowercaseString hasPrefix:@"http"]) {
        if ([SFSafariViewController class]) {
            SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:URL entersReaderIfAvailable:NO];
            
            [self openViewController:safariViewController navigationType:CENavigationTypeModal animated:YES completion:completion];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
        
        return;
    }
    
    //find class for route
    NSString *route = [URL path];
    [self openRoute:route params:params navigationType:navigationType completion:completion];
}

- (void)openRoute:(NSString *)route params:(NSDictionary *)params completion:(void (^)(UIViewController * _Nullable, NSError * _Nullable))completion
{
    [self openRoute:route params:params navigationType:CENavigationTypePush completion:completion];
}

- (void)openRoute:(NSString *)route params:(NSDictionary *)params navigationType:(CENavigationType)navigationType completion:(void (^)(UIViewController * _Nullable, NSError * _Nullable))completion
{
    Class routeClass = [self classForRoute:route params:&params];
    
    //if route is not reachable return error
    if (![routeClass conformsToProtocol:@protocol(CERoutable)]) {
        if (completion) {
            completion(nil, nil);
        }
        return;
    }
    
    UIViewController <CERoutable> *viewController;
    if ([routeClass instancesRespondToSelector:@selector(initWithParams:)]) {
        viewController = [[routeClass alloc] initWithParams:params];
        
    } else {
        viewController = [routeClass new];
    }
    
    if (!viewController) {
        if (completion) {
            completion(nil, nil);
        }
        return;
    }
    
    if (navigationType == CENavigationTypePush) {
        if (self.navigationProvider.currentViewController.navigationController) {
            [self openViewController:viewController navigationType:CENavigationTypePush animated:YES completion:completion];
        } else {
            [self openViewController:viewController navigationType:CENavigationTypeModal animated:YES completion:completion];
        }
    } else {
        [self openViewController:viewController navigationType:CENavigationTypeModal animated:YES completion:completion];
    }
}

#pragma mark - Private

- (void)openViewController:(UIViewController *)viewController navigationType:(CENavigationType)navigationType animated:(BOOL)animated completion:(void (^)(UIViewController * _Nullable, NSError * _Nullable))completion
{
    RACSignal *viewWillDisappearSignal = [viewController rac_signalForSelector:@selector(viewWillDisappear:)];
    
    @weakify(self);
    [viewWillDisappearSignal subscribeNext:^(id x) {
        @strongify(self);
        
        if (viewController.presentingViewController) {
            self.navigationProvider.currentViewController = viewController.presentingViewController;
        } else {
            self.navigationProvider.currentViewController = self.navigationProvider.rootViewController;
        }
    }];
    
    switch (navigationType) {
        case CENavigationTypePush: {
            [self.navigationProvider.currentViewController.navigationController pushViewController:viewController animated:animated];
            break;
        }
        case CENavigationTypeModal: {
            [self.navigationProvider.currentViewController presentViewController:viewController animated:animated completion:^{
                self.navigationProvider.currentViewController = viewController;
                if (completion) {
                    completion(viewController, nil);
                }
            }];
            break;
        }
        default:
            break;
    }
}

- (nullable Class)classForRoute:(NSString *)route params:(NSDictionary **)params
{
    NSDictionary *routesMap = [self routesMap];
    
    __block Class class;
    __block NSDictionary *routeParams;
    __block NSString *originalRoute = route;
    
    [routesMap each:^(NSString *constantRoute, id routeClass) {
        if (class) {
            return;
        }
        NSDictionary *paramsForMatchedRoute = [self paramsForMatchedRoute:originalRoute constantRoute:constantRoute];
        if (paramsForMatchedRoute) {
            if ([routeClass isKindOfClass:[NSString class]]) {
                class = NSClassFromString(routeClass);
            } else if (object_isClass(routeClass)) {
                class = routeClass;
            }
            
            routeParams = paramsForMatchedRoute;
        }
    }];
    
    NSMutableDictionary *mergedParams = [NSMutableDictionary new];
    if (routeParams.allKeys.count) {
        [mergedParams addEntriesFromDictionary:routeParams];
    }
    
    if ([*params allKeys].count) {
        [mergedParams addEntriesFromDictionary:*params];
    }
    
    *params = mergedParams;
    
    return class;
}

- (nullable NSDictionary *)paramsForMatchedRoute:(nonnull NSString *)originalRoute constantRoute:(nonnull NSString *)constantRoute
{
    NSArray *constantPathComponents = [constantRoute componentsSeparatedByString:@"/"];
    NSArray *routePathComponents = [originalRoute componentsSeparatedByString:@"/"];
    
    //precheck
    if (constantPathComponents.count != routePathComponents.count) {
        return nil;
    }
    
    __block BOOL routeIsEqual = YES;
    __block NSMutableArray *paramsIndexes = [NSMutableArray new];
    
    [constantPathComponents eachWithIndex:^(NSString *constantPathComponent, NSUInteger index) {
        if (![constantPathComponent hasPrefix:kRouteParamPrefix]) {
            NSString *routePathComponent = routePathComponents[index];
            if (![constantPathComponent.lowercaseString isEqualToString:routePathComponent.lowercaseString]) {
                routeIsEqual = NO;
            }
        } else {
            [paramsIndexes addObject:@(index)];
        }
    }];
    
    if (!routeIsEqual) {
        return nil;
    }
    
    __block NSMutableDictionary *params = [NSMutableDictionary new];
    
    [paramsIndexes each:^(NSNumber *index) {
        NSString *key = [constantPathComponents[index.integerValue] substringFromIndex:1].lowercaseString;
        NSString *value = routePathComponents[index.integerValue];
        
        params[key] = value;
    }];
    
    return params;
}
#pragma mark - Properties

- (id<CENavigationProvider>)navigationProvider
{
    id<CENavigationProvider> provider = [CEContext defaultContext].navigationProvider;
    
    return provider;
}

@end
