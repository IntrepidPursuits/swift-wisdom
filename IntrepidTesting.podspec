Pod::Spec.new do |s|
  s.name          = "IntrepidTesting"
  s.version       = "0.9.0-beta"
  s.summary       = "A collection of test extensions to the Swift Standard Library"
  s.description   = <<-DESC
                    Collection of test extensions and utility classes by and for the developers at Intrepid Pursuits.
                    DESC
  s.homepage      = "https://github.com/IntrepidPursuits/swift-wisdom"
  s.license       = "MIT"
  s.authors       = { "Colden Prime" => "colden@intrepid.io" }
  s.source        = { :git => "https://github.com/IntrepidPursuits/swift-wisdom.git", :tag => "#{s.version}" }
  s.platform      = :ios
  s.ios.deployment_target = "8.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.default_subspec = "Core"

  s.subspec "Core" do |cs|
    cs.frameworks    = "XCTest"
    cs.source_files  = "SwiftWisdomTests/Testing/**/*.swift"
  end
end
