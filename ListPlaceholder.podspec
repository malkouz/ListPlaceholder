#
# Be sure to run `pod lib lint ListPlaceholder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'ListPlaceholder'
    s.version          = '1.4'
    s.summary          = 'facebook news feed style animation on UITableView, UICollectionView, and custom views.'
    s.xcconfig = { "OTHER_LDFLAGS" => "-lz" }
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    This library allows you to easily add an FB style animated loading placeholder to your tableviews, collection views, or custom views.
    DESC
    
    s.homepage         = 'https://github.com/malkouz/ListPlaceholder'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Moayad Al kouz' => 'moayad_kouz9@hotmail.com' }
    s.source           = { :git => 'https://github.com/malkouz/ListPlaceholder.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/malkouz'
    
    s.ios.deployment_target = '8.0'
    
    s.source_files = 'ListPlaceholder/Classes/**/*'
    
    # s.resource_bundles = {
    #   'ListPlaceholder' => ['ListPlaceholder/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
