#import <Foundation/Foundation.h>

#import "CEAPIClient.h"

@protocol CENetworkService <NSObject>

@property (strong, nonatomic, nonnull) CEAPIClient *APIClient;

@end
