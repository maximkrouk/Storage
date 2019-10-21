Pod::Spec.new do |s|
  s.name             = 'CocoaStorageKit'
  s.version          = '0.1.0'
  s.summary      = 'The most swift framework for your apps.'

  s.description      =  <<-DESC
- Thread safe storage managers and providers for keychain, userdefaults, temporary and persistent cache.
                       DESC

  s.homepage         = 'https://github.com/maximkrouk/Storage'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Maxim Krouk' => 'id.maximkrouk@gmail.com' }
  s.source           = { :git => 'https://github.com/maximkrouk/Storage.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/maximkrouk'

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.1'
  s.source_files = 'Sources/**/**/**/*'
  s.frameworks = 'UIKit', 'Foundation', 'Security'

  s.dependency 'Convenience'
end
