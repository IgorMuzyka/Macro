platform :osx, '10.14'

target 'Macro' do

  pod 'Omnibus', :git => 'https://github.com/IgorMuzyka/Omnibus.git'
  pod 'MenuBar', :git => 'https://github.com/IgorMuzyka/MenuBar.git'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.14'
		end
	end
end
