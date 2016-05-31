#import "CELocalDeviceUDIDProvider.h"

static NSString * const CEDeviceUUIDKeychainStorageKey = @"CEDeviceUUIDKeychainStorageKey";
static NSString * const CEDeviceUUIDUserDefaultsStorageKey = @"CEDeviceUUIDUserDefaultsStorageKey";

@interface CELocalDeviceUDIDProvider ()

@property (strong, nonatomic, nonnull) id <CEKeychainStorageService> keychainStorageService;

@end

@implementation CELocalDeviceUDIDProvider

- (NSUUID *)currentDeviceUUID
{
    NSString *UUIDString;
    
    if (!UUIDString) {
        UUIDString = [self valueForKeychainKey:CEDeviceUUIDKeychainStorageKey];
    }
    if (!UUIDString) {
        UUIDString = [self valueForUserDefaultsKey:CEDeviceUUIDUserDefaultsStorageKey];
    }
    if (!UUIDString) {
        UUIDString = [self appleIFV];
    }
    if (!UUIDString) {
        UUIDString = [self randomUUID];
    }
    
    [self saveUUID:UUIDString];
    
    return [[NSUUID alloc] initWithUUIDString:UUIDString];
}

#pragma mark - Private

- (void)saveUUID:(NSString *)UUIDString
{
    if (![self valueForUserDefaultsKey:CEDeviceUUIDUserDefaultsStorageKey]) {
        [[NSUserDefaults standardUserDefaults] setObject:UUIDString forKey:CEDeviceUUIDUserDefaultsStorageKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (![self valueForKeychainKey:CEDeviceUUIDKeychainStorageKey]) {
        [self.keychainStorageService storeObject:UUIDString forKey:CEDeviceUUIDKeychainStorageKey inService:nil error:nil];
    }
}

- (nullable NSString *)valueForKeychainKey:(NSString *)key
{
    return [self.keychainStorageService objectForKey:key error:nil];
}

- (nullable NSString *)valueForUserDefaultsKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (nullable NSString *)appleIFV
{
    if (NSClassFromString(@"UIDevice") && [UIDevice instancesRespondToSelector:@selector(identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return nil;
}

- (nonnull NSString *)randomUUID {
    if (NSClassFromString(@"NSUUID")) {
        return [NSUUID UUID].UUIDString;
    }
    
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    
    return uuid;
}

#pragma mark - Properties

- (id<CEKeychainStorageService>)keychainStorageService
{
    return [CEContext defaultContext].keychainStorageService;
}

@end
