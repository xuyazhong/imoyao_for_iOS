//
//  imoyao.h
//  imoyao
//
//  Created by xuyazhong on 2019/1/7.
//

#import <Foundation/Foundation.h>

typedef void(^espBlock)(BOOL isSucc, NSString *result);

@interface imoyao : NSObject

+ (imoyao *)sharedMoyao;

// 获取SSID
- (NSString *)getSSID;

// 获取BSSID
- (NSString *)getBSSID;

// 传入无线密码配网
- (void)Connect:(NSString *)passwd block:(espBlock)block;

@end
