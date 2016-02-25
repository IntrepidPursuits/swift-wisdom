Pod::Spec.new do |s|
  s.name          = "IntrepidSwiftWisdom"
  s.version       = "0.1.6"
  s.summary       = "Swift Bag"
  s.description   = <<-DESC
                    A collection of extensions to the Swift Standard Library and general Cocoa helpers written by
                    the developers of Intrepid Pursuits to speed up repeatable aspects of iOS development.
                    DESC
  s.homepage      = "https://github.com/IntrepidPursuits/swift-wisdom"
  s.license       = "MIT"
  s.authors       = { "Logan Wright" => "logan@intrepid.io" }
  s.source        = { :git => "https://github.com/IntrepidPursuits/swift-wisdom.git", :tag => "#{s.version}" }
  s.exclude_files = "tests/**/*"
  s.platform      = :ios
  s.ios.deployment_target = "8.0"
  s.default_subspec = "Core"

  s.subspec "Core" do |cs|
    cs.source_files = "SwiftWisdom/Core/**/**/*.swift"
    cs.dependency 'IP-UIKit-Wisdom', '0.0.9'
  end
end
