//
//  CRC.h
//  imoyao
//
//  Created by xuyazhong on 2019/1/10.
//

#import <Foundation/Foundation.h>

@interface NSString (CRC) 

- (NSString *)CRC_CCITT;
- (NSData *)toNSData;
- (NSString *)toNSString:(NSData*)data;

@end
