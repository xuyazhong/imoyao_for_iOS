//
//  imoyao.m
//  imoyao
//
//  Created by xuyazhong on 2019/1/7.
//

#import "imoyao.h"

@interface imoyao()<ESPTouchDelegate>

@end

@implementation imoyao {
    espBlock _block;
}
static imoyao *_shared = nil;

+ (imoyao *)sharedMoyao {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (NSString *)getSSID {
    return [self fetchSsid];
}

- (NSString *)getBSSID {
    return [self fetchBssid];
}

- (void)Connect:(NSString *)passwd block:(espBlock)block {
    _block = block;
    NSString *ssid = [self getSSID];
    NSString *bssid = [self getBSSID];
    int taskCount = 1;
    BOOL broadcast = YES;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSArray *esptouchResultArray = [self executeForResultsWithSsid:ssid bssid:bssid password:passwd taskCount:taskCount broadcast:broadcast];
        dispatch_async(dispatch_get_main_queue(), ^{
            ESPTouchResult *firstResult = [esptouchResultArray objectAtIndex:0];
//            NSLog(@"esptouchResultArray =>[%@]", firstResult);
            _block(firstResult);
        });
    });
}

#pragma mark - the example of how to use executeForResults
- (NSArray *)executeForResultsWithSsid:(NSString *)apSsid bssid:(NSString *)apBssid password:(NSString *)apPwd taskCount:(int)taskCount broadcast:(BOOL)broadcast {
    ESPTouchTask *esptouchTask = [[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd];
    [esptouchTask setEsptouchDelegate:self];
    [esptouchTask setPackageBroadcast:broadcast];
    NSArray *esptouchResults = [esptouchTask executeForResults:taskCount];
    return esptouchResults;
}

#pragma mark - delegate
- (void)onEsptouchResultAddedWithResult:(ESPTouchResult *) result {
    NSLog(@"EspTouchDelegateImpl onEsptouchResultAddedWithResult bssid: %@", result.bssid);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        _block(result);
//    });
}

#pragma mark - custom

- (NSString *)fetchSsid {
    NSDictionary *ssidInfo = [self fetchNetInfo];
    return [ssidInfo objectForKey:@"SSID"];
}

- (NSString *)fetchBssid {
    NSDictionary *bssidInfo = [self fetchNetInfo];
    return [bssidInfo objectForKey:@"BSSID"];
}

// refer to http://stackoverflow.com/questions/5198716/iphone-get-ssid-without-private-library
- (NSDictionary *)fetchNetInfo {
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
        NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
                NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}

@end
