#
# Be sure to run `pod lib lint GSBasis.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GSBasis'
  s.version          = '0.1.0'
  s.summary          = 'Basic components of the GS series components'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gloomy.meng.049@gmail.com/GSBasis'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gloomy.meng.049@gmail.com' => 'gloomy.meng.049@gmail.com' }
  s.source           = { :git => 'https://github.com/gloomy.meng.049@gmail.com/GSBasis.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.default_subspecs = 'Common'
  s.source_files = 'GSBasis/Classes/**/*'
  
  s.subspec 'Common' do |ss|
      ss.source_files = 'GSBasis/Classes/**/*'
      ss.dependency 'Then'
  end
  
  s.subspec 'UIKit' do |ss|
      ss.source_files = 'GSBasis/UIKit/**/*'
  end
end
