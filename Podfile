source 'https://github.com/CocoaPods/Specs'

platform :ios, '8.0'

use_frameworks!

def commonpods
  pod 'IP-UIKit-Wisdom'
  pod 'RxSwift', '~> 2.0'
  pod 'RxCocoa', '~> 2.0'
end

target 'SwiftWisdom' do
  commonpods()
end

target 'SwiftWisdomTests' do
  commonpods()
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
