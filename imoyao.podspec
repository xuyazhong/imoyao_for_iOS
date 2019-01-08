Pod::Spec.new do |s|
  s.name             = 'imoyao'
  s.version          = '0.1.0'
  s.summary          = 'A short description of imoyao.'

  s.description      = <<-DESC
imoyao库.
                       DESC

  s.homepage         = 'https://github.com/xuyazhong/imoyao'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xuyazhong' => 'yazhongxu@gmail.com' }
  s.source           = { :git => 'https://github.com/xuyazhong/imoyao.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  # s.source_files  = "Classes", "Classes/*.{h,m}"
  s.source_files = 'imoyao/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.requires_arc = true
  s.dependency 'BabyBluetooth', '~> 0.7.0'
  # s.resource_bundles = {
  #   'imoyao' => ['imoyao/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

end
