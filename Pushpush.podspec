Pod::Spec.new do |s|
  s.name         = "Pushpush"
  s.version      = "0.0.1"
  s.summary      = "iOS subscriber for SDK for Pushpush."
  s.homepage     = "http://wrep.nl/"
  s.license      = 'MIT'
  s.author       = { "Wrep" => "info@wrep.nl" }
  s.source       = { :git => "https://github.com/wrep/pushpush-ios.git" }
  s.platform     = :ios, '4.0'
  s.source_files = ['Pushpush Subscriber']
  s.requires_arc = true

  s.public_header_files = 'Pushpush Subscriber/Pushpush.h'
  s.framework  = 'SystemConfiguration'
  
  # Finally, specify any Pods that this Pod depends on.
  #
  s.dependency 'Reachability', '~> 3.1'
end
