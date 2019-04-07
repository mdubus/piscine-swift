#
# Be sure to run `pod lib lint mdubus2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'mdubus2019'
    s.version          = '0.1.0'
    s.summary          = 'Just a pod for d08 of piscine Swift - School 42.'
    s.swift_version    = '4.0'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    This is a pod for the day 08 of the piscine Swift. It will be used to manage Articles in a Diary.
    DESC
    
    s.homepage         = 'https://www.42.fr'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Morgane DUBUS' => 'mdubus@student.42.fr' }
    s.source           = { :git => 'https://github.com/Morgane DUBUS/mdubus2019.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    s.source_files = 'mdubus2019/**/*.{h,m,swift,xcdatamodeld}'
    
    # s.resource_bundles = {
    #   'mdubus2019' => ['mdubus2019/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MapKit', 'CoreData'
    # s.dependency 'AFNetworking', '~> 2.3'
end
