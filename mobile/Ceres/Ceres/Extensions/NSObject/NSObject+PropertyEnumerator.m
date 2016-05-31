#import "NSObject+PropertyEnumerator.h"
#import <objc/runtime.h>

@implementation NSObject (PropertyEnumerator)

- (NSArray <CEObjectProperty*> *)objectProperties
{
    __block unsigned int outCount, i;
    __block NSMutableArray <CEObjectProperty*> *propertiesArray = [NSMutableArray new];
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyType = [self getPropertyType:property];
            NSString *propertyName = [NSString stringWithCString:propName
                                                        encoding:[NSString defaultCStringEncoding]];
            id propertyValue = [self valueForKey:(NSString *)propertyName];
            
            CEObjectProperty *objectProperty = [CEObjectProperty new];
            objectProperty.propertyValue = propertyValue;
            objectProperty.propertyName = propertyName;
            
            if ([[propertyType substringToIndex:1] isEqualToString:@"<"] && [[propertyType substringFromIndex:propertyType.length - 1] isEqualToString:@">"]) {
                objectProperty.propertyProtocol = [propertyType stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
            } else {
                objectProperty.propertyType = propertyType;
            }
            
            [propertiesArray addObject:objectProperty];
        }
    }
    
    free(properties);
    
    return propertiesArray;
}


#pragma mark - Private

- (NSString *)getPropertyType:(objc_property_t)property
{
    NSString *attributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    
    NSArray *components = [attributes componentsSeparatedByString:@","];
    
    NSString *propertyTypeString = [components find:^BOOL(NSString *component) {
        if ([[component substringToIndex:1] isEqualToString:@"T"]) {
            return component.length > 4;
        }
        
        return NO;
    }];
    
    NSArray *propertyTypeComponents = [propertyTypeString componentsSeparatedByString:@"\""];
    
    return propertyTypeComponents[1];
}

@end
