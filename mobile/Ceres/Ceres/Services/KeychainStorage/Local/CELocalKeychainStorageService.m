#import "CELocalKeychainStorageService.h"

@implementation CELocalKeychainStorageService


- (id)objectForKey:(NSString *)key error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    // setup keychain query properties
    NSDictionary *readQuery = @{
                                (__bridge id)kSecAttrAccount:key,
                                (__bridge id)kSecReturnData:(id)kCFBooleanTrue,
                                (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword
                                };
    
    CFDataRef serializedObject = NULL;
    if(SecItemCopyMatching((__bridge CFDictionaryRef)readQuery, (CFTypeRef *)&serializedObject) == noErr) {
        // deserialize object
        NSData *data = (__bridge NSData *)serializedObject;
        id storedObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return storedObject;
    } else {
        if (error) {
#warning TODO return error
        }
        return nil;
    }
}

- (void)storeObject:(id)object forKey:(NSString *)key inService:(NSString *)service error:(NSError *__autoreleasing  _Nullable * _Nullable)error
{
    [self deleteObjectForKey:key error:nil];
    
    NSData *serializedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    [self deleteObjectForKey:key error:nil];
    
    NSDictionary *storageQuery = @{
                                   (__bridge id)kSecAttrAccount:key,
                                   (__bridge id)kSecValueData:serializedObject,
                                   (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                   (__bridge id)kSecAttrAccessible:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly
                                   };
    OSStatus osStatus = SecItemAdd((__bridge CFDictionaryRef)storageQuery, nil);
    if (osStatus != noErr && error) {
#warning TODO return error
    }
}

- (void)deleteObjectForKey:(NSString *)key error:(NSError *__autoreleasing  _Nullable * _Nullable)error
{
    NSDictionary *deletableItemsQuery = @{
                                          (__bridge id)kSecAttrAccount:key,
                                          (__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                          (__bridge id)kSecMatchLimit:(__bridge id)kSecMatchLimitAll,
                                          (__bridge id)kSecReturnAttributes:(id)kCFBooleanTrue
                                          };
    
    CFArrayRef itemList = nil;
    OSStatus osStatus = SecItemCopyMatching((__bridge CFDictionaryRef)deletableItemsQuery, (CFTypeRef *)&itemList);
    
    NSArray *itemListArray = (__bridge NSArray *)itemList;
    for (id item in itemListArray) {
        NSMutableDictionary *deleteQuery = [item mutableCopy];
        [deleteQuery setValue:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        
        // delete
        osStatus = SecItemDelete((__bridge CFDictionaryRef)deleteQuery);
        if(osStatus != noErr && error) {
#warning TODO return error
        }
    }
}

- (void)deleteAllObjects:(NSError *__autoreleasing  _Nullable *)error
{
    NSArray *secItemClasses = @[(__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecClassInternetPassword,
                                (__bridge id)kSecClassCertificate,
                                (__bridge id)kSecClassKey,
                                (__bridge id)kSecClassIdentity];
    
    for (id secItemClass in secItemClasses) {
        NSDictionary *spec = @{(__bridge id)kSecClass: secItemClass};
        OSStatus osStatus = SecItemDelete((__bridge CFDictionaryRef)spec);
        if(osStatus != noErr && error) {
#warning TODO return error
        }
    }
}

@end
