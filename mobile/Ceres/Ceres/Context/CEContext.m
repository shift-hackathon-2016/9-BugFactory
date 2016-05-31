#import "CEContext.h"

#import "CEObjectProperty.h"

//services
#import "CENetworkAuthenticationService.h"
#import "CELocalKeychainStorageService.h"
#import "CELocalPushNotificationService.h"

//providers
#import "CELocalDeviceUDIDProvider.h"
#import "CELocalDeviceNotificationsTokenProvider.h"

@implementation CEContext

+ (instancetype)defaultContext
{
    static dispatch_once_t onceToken;
    static CEContext *defaultContext;
    dispatch_once(&onceToken, ^{
        defaultContext = [CEContext new];
        
        [defaultContext setServices:[self services]];
        [defaultContext setProviders:[self providers]];
    });
    
    return defaultContext;
}

#pragma mark - Services
+ (NSArray <Class> *)services
{
    return @[
             [CENetworkAuthenticationService class],
             [CELocalKeychainStorageService class],
             [CELocalPushNotificationService class]
             ];
}

#pragma mark - Providers
+ (NSArray <Class> *)providers
{
    return @[
             [CELocalDeviceUDIDProvider class],
             [CELocalDeviceNotificationsTokenProvider class]
             ];
}

#pragma mark - Private
- (void)setServices:(NSArray <Class> *)services
{
    NSArray *serviceInstances = [services map:^id(Class serviceClass) {
        return [serviceClass new];
    }];
    
    [self.objectProperties each:^(CEObjectProperty *objectProperty) {
        Protocol *objectPropertyProtocol = NSProtocolFromString(objectProperty.propertyProtocol);
        [serviceInstances each:^(id serviceInstance) {
            if ([serviceInstance conformsToProtocol:objectPropertyProtocol]) {
                [self setValue:serviceInstance forKey:objectProperty.propertyName];
            }
        }];
    }];
}

- (void)setProviders:(NSArray <Class> *)providers
{
    NSArray *providerInstances = [providers map:^id(Class providerClass) {
        return [providerClass new];
    }];
    
    [providerInstances each:^(id providerInstance) {
        [self.objectProperties each:^(CEObjectProperty *objectProperty) {
            Protocol *objectPropertyProtocol = NSProtocolFromString(objectProperty.propertyProtocol);
            if ([providerInstance conformsToProtocol:objectPropertyProtocol]) {
                [self setValue:providerInstance forKey:objectProperty.propertyName];
            }
        }];
    }];
}

@end
