#import <Foundation/Foundation.h>

@interface CEObjectProperty : NSObject

@property (strong, nonatomic, nullable) id propertyValue;
@property (strong, nonatomic, nonnull) NSString *propertyName;
@property (strong, nonatomic, nullable) NSString *propertyType;
@property (strong, nonatomic, nullable) NSString *propertyProtocol;

@end
