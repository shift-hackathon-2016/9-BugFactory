#import "CELocalDeviceLocationService.h"

@interface CELocalDeviceLocationService () <CLLocationManagerDelegate>

@property (strong, nonatomic, nonnull) CLLocationManager *locationManager;

@end

@implementation CELocalDeviceLocationService

- (RACSignal *)currentDeviceLocation
{
    return [RACSignal return:self.locationManager.location];
}

#pragma mark - CLLocationManagerDelegate

#pragma mark - Private

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
    }
    
    return _locationManager;
}

@end
