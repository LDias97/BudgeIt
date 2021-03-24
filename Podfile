platform :ios, '14.0'

target 'Rev0' do
  use_frameworks!
	pod 'Plaid'
	pod 'Firebase'
	pod 'Firebase/Firestore'
	pod 'Firebase/Auth'
	pod 'Firebase/Functions'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == 'Debug'
        config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
end

