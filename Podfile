# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'SoraX' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire', "~> 5.7.1"
  pod 'SDWebImage'
  pod 'Toast-Swift'

#  # Pods for SoraX
  post_install do |installer|
#    installer.pods_project.build_configurations.each do |config|
#      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#    end
#    
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "14.0"
        end
      end
    end
  end
end

