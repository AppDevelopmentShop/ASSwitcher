#
# Be sure to run `pod lib lint ASSwitcher.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.ios.deployment_target = '10.0'
  s.name             = 'ASSwitcher'
  s.version          = '0.1.1'
  s.swift_version    = '4.0'
  s.summary          = 'Now easy to make custom switcher with images and borders'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Now easy to make custom switcher with images and borders. Install library into project^ never have to write this generic code again!
                        DESC

  s.homepage         = 'https://github.com/AppDevelopmentShop/ASSwitcher'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mvolkov-42' => 'maxvolkov.inc@gmail.com' }
  s.source           = { :git => 'https://github.com/AppDevelopmentShop/ASSwitcher.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Classes/**/*'
  
  # s.resource_bundles = {
  #   'ASSwitcher' => ['ASSwitcher/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
