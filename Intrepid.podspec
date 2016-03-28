Pod::Spec.new do |s|
  s.name          = "Intrepid"
  s.version       = "0.2.0"
  s.summary       = "Swift Bag"
  s.description   = <<-DESC
                    Collection of extensions and utility classes by and for the developers at intrepid pursuits.
                    DESC
  s.homepage      = "https://github.com/IntrepidPursuits/swift-wisdom"
  s.license       = "MIT"
  s.authors       = { "Intrepid Pursuits" => "logan@intrepid.io" }
  s.social_media_url = 'https://twitter.com/itpd'
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
