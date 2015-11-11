Pod::Spec.new do |s|
  s.name          = "IntrepidSwiftWisdom"
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
  s.default_subspec = "Core"

  s.subspec "Core" do |cs|
    cs.source_files = "SwiftWisdom/SwiftWisdom/Core/**/**/*.swift"
  end
end
