use_frameworks!
platform :ios, '10.0'
target 'Example' do
  pod 'ListPlaceholder', :path => '../'

  target 'Example_Tests' do
    inherit! :search_paths

    
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end
