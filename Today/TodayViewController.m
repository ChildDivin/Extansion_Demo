//
//  TodayViewController.m
//  Today
//
//  Created by Tops on 7/27/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
{
    double rate;
    NSTimer *timer;
    NSDate *date;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    geocoder = [[CLGeocoder alloc] init];

    [self _timerFired:nil];
    rate =0;
    date =[[NSDate alloc] init];
    NSDateFormatter *formate =[[NSDateFormatter alloc] init];
    formate.dateFormat= @"yyyy-MM-dd ";
    NSLog(@"%@",[formate stringFromDate:date]);
    self.lblDate.text=[formate stringFromDate:date];
    NSUserDefaults *userdefault = [[NSUserDefaults standardUserDefaults] initWithSuiteName:@"group.shringData"];
    NSLog(@"%@",[userdefault objectForKey:@"KeyName"]);
}
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
    [self updateSizes];
}
- (void)updateSizes
{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(_timerFired:) userInfo:nil repeats:YES];
}
- (void)_timerFired:(NSTimer *)ti
{
    if (rate>1.0) {
        if (timer)
        [timer invalidate];
    }else
    {
    rate= rate + 0.1;
    self.lblPer.text =
    [NSString stringWithFormat:@"%.f %@", (rate * 100),@"%"];
    self.progress.progress = rate;
    }

}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
   self.preferredContentSize = CGSizeMake(0,180);
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
      [locationManager stopUpdatingLocation];
    if (currentLocation != nil) {
        NSLog(@"Resolving the Address");
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
                self.lblDate.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                     placemark.subThoroughfare, placemark.thoroughfare,
                                     placemark.postalCode, placemark.locality,
                                     placemark.administrativeArea,
                                     placemark.country];
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
    }
}
@end
