Pod::Spec.new do |s|
  s.name          = "IntrepidSwiftWisdomTesting"
  s.version       = "0.0.7"
  s.summary       = "A collection of extensions to the Swift Standard Library"
  s.description   = <<-DESC
                    A collection of extensions to the Swift Standard Library, written by the developers of Intrepid Pursuits.
                    DESC
  s.homepage      = "https://github.com/IntrepidPursuits/swift-wisdom"
  s.license       = "MIT"
  s.authors       = { "Logan Wright" => "logan@intrepid.io" }
  s.source        = { :git => "https://github.com/IntrepidPursuits/swift-wisdom.git", :tag => "0.0.7" }
  s.exclude_files = "tests/**/*"
  s.platform      = :ios
  s.ios.deployment_target = "8.0"
  s.source_files  = "SwiftWisdom/SwiftWisdomTests/Testing/**/*.swift"
  s.frameworks    = "XCTest"
end
