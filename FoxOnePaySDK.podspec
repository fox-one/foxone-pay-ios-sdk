Pod::Spec.new do |s|
  s.name         = "FoxOnePaySDK"
  s.version      = "2.0.0"
  s.summary      = "FoxOne Pay SDK"

  s.description  = "FoxOne Pay SDK for iOS"

  s.homepage     = "https://github.com/fox-one/foxone-pay-ios-sdk"
  s.license      = "Apache License 2.0"
  s.author             = { "moubuns" => "mengwl@fox.one" }
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/fox-one/foxone-pay-ios-sdk.git", :tag => "#{s.version}" }

  s.source_files  = "paySDK/**/*.swift"
  s.resources = "paySDK/Resource/**/*.*"
  s.swift_version = "5.0"
  s.requires_arc = true
  s.dependency "Alamofire" 
  s.dependency "SwiftyJSON"
  s.dependency "SwiftyRSA"
  s.dependency "CryptoSwift"

end
