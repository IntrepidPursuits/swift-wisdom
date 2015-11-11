
platform :ios, '8.0'

def global_import
    pod 'IntrepidSwiftWisdom', :path => '..'
end

target 'SwiftWisdomPods', :exclusive => true do
    use_frameworks!
    global_import
end

target 'SwiftWisdomTests', :exclusive => true do
    use_frameworks!
    global_import
    pod 'IntrepidSwiftWisdomTesting', :path => '..'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
