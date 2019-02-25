# 无线配网 

基于 Esptouch 开发，支持 Smart Config 、 Airkiss 配网

Esptouch v0.3.4.6 only support Espressif's Smart Config v2.4

## 集成

```ruby
pod 'imoyao', :git => 'git@github.com:xuyazhong/imoyao_for_iOS.git'
```

运行 pod install

## 用法

```
#import <imoyao/imoyao.h>

[[imoyao sharedMoyao] Connect:self.passwdTF.text block:^(BOOL isSucc, NSString *result) {
    if (isSucc) {
        // 配网成功
    } else {
        // 配网失败
    }
}];
```

## Author

xuyazhong, yazhongxu@gmail.com

## License

imoyao is available under the MIT license. See the LICENSE file for more info.
