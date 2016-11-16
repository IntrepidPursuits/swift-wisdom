Pod::Spec.new do |s|
  s.name          = "Intrepid"
  s.version       = "0.6.3"
  s.summary       = "Swift Bag"
  s.description   = <<-DESC
                    Collection of extensions and utility classes by and for the developers at intrepid pursuits.
                    DESC
  s.homepage      = "https://github.com/IntrepidPursuits/swift-wisdom"
  s.license       = "MIT"
  s.authors       = { "Logan Wright" => "logan@intrepid.io",
                      "Eric Peterson" => "eric@intrepid.io",
                      "Ying Quan Tan" => "ying@intrepid.io",
                      "Colden Prime" => "colden@intrepid.io",
                      "Ben Wu" => "ben@intrepid.io",
                      "Maya Saxena" => "maya@intrepid.io",
                      "Alex Persian" => "alex@intrepid.io",
                      "Tom O'Malley" => "tom@intrepid.io",
                      "Alan Scarpa" => "alan@intrepid.io",
                      "Paul Rolfe" => "paul@intrepid.io",
                      "Colin Tan" => "ctan@intrepid.io",
                      "Stephen Wingchi Wong" => "stephenwong@intrepid.io"
                    }
  s.social_media_url = 'https://twitter.com/intpd'
  s.source        = { :git => "https://github.com/IntrepidPursuits/swift-wisdom.git", :tag => "#{s.version}" }
  s.exclude_files = "tests/**/*"
  s.platform      = :ios
  s.ios.deployment_target = "8.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
  s.default_subspec = "Core"

  s.subspec "Core" do |cs|
    cs.source_files = "SwiftWisdom/Core/**/**/*.swift"
    cs.dependency 'IP-UIKit-Wisdom', '0.0.9'
  end

  s.subspec "Rx" do |rx|
    rx.source_files = "SwiftWisdom/Rx/**/**/*.swift"
    rx.dependency 'RxSwift', '~> 3.0.0-beta.2'
    rx.dependency 'RxCocoa', '~> 3.0.0-beta.2'
  end
end
