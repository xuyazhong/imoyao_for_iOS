//
//  imoyao.m
//  imoyao
//
//  Created by xuyazhong on 2019/1/7.
//

#import "imoyao.h"
#import "ESP_Helper.h"
#import "ESP_NetUtil.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface imoyao()

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
//    NSString *ssid = [self getSSID];
//    NSString *bssid = [self getBSSID];
    
    [ESP_Helper start:passwd callback:^(ESPTouchResult *result) {
        
        if (!result.isCancelled) {
            
            if (result.isSuc) {
                NSString *ipAddrDataStr = [ESP_NetUtil descriptionInetAddr4ByData:result.ipAddrData];
                if (ipAddrDataStr==nil) {
                    ipAddrDataStr = [ESP_NetUtil descriptionInetAddr6ByData:result.ipAddrData];
                }
                NSLog(@"ip :%@ description:%@", ipAddrDataStr, result);
                _block(YES, ipAddrDataStr);
            } else {
                _block(NO, @"error");
            }
            
        } else {
            _block(NO, @"cancel");
        }
        
    }];
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
