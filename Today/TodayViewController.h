//
//  TodayViewController.h
//  Today
//
//  Created by Tops on 7/27/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TodayViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (strong, nonatomic) IBOutlet UILabel *lblPer;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (nonatomic, assign) unsigned long long fileSystemSize;
@property (nonatomic, assign) unsigned long long freeSize;
@property (nonatomic, assign) unsigned long long usedSize;
@property (nonatomic, assign) double usedRate;

@end
