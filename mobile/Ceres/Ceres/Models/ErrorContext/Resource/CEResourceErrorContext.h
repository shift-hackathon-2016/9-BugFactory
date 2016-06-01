#import <Foundation/Foundation.h>

@interface CEResourceErrorContext : NSObject <CEErrorContext>

@property (assign, nonatomic) NSInteger statusCode;
@property (strong, nonatomic, nonnull) NSString *title;
@property (strong, nonatomic, nonnull) NSString *message;

@end
