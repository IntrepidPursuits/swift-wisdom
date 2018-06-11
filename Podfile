source 'https://github.com/CocoaPods/Specs'

platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

def commonpods
  pod 'IP-UIKit-Wisdom'
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
end

target 'SwiftWisdom' do
  commonpods()
end

target 'SwiftWisdomTests' do
  commonpods()
  pod 'RxTest', '~> 4.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.12'
    end
  end
end
