# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

# Specify the minimum deployment target
deployment_target = '15.0'

target 'ZeticMLangeLLMSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ZeticMLangeLLMSample
  pod 'ZeticMLange', :podspec => './Podspecs/ZeticMLange.podspec'
end

# MARK: - Post Install Configuration
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Set minimum deployment target for all pods
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
      
      # Fix warnings for newer Xcode versions
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      
      # Enable module stability for custom frameworks
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      
      # Code signing settings for custom frameworks
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end
