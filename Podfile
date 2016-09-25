# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'MVVMTestProject' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MVVMTestProject
  pod 'Bond', '~> 5.0-beta2'
  pod "PromiseKit", "~> 4.0"
  target 'MVVMTestProjectTests' do
    inherit! :search_paths
    pod 'Bond', '~> 5.0-beta2'
    pod "PromiseKit", "~> 4.0"
    # Pods for testing

  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
