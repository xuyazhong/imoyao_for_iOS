//
//  imoyao.h
//  imoyao
//
//  Created by xuyazhong on 2019/1/7.
//

#import <Foundation/Foundation.h>
#import "ESPTouchTask.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"
#import "ESPAES.h"
#import "ESPTouchResult.h"
#import <SystemConfiguration/CaptiveNetwork.h>

typedef void(^espBlock)(ESPTouchResult *result);

@interface imoyao : NSObject

+ (imoyao *)sharedMoyao;

// 获取SSID
- (NSString *)getSSID;

// 获取BSSID
- (NSString *)getBSSID;

// 传入无线密码配网
- (void)Connect:(NSString *)passwd block:(espBlock)block;

@end
