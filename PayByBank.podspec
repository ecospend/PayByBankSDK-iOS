Pod::Spec.new do |spec|
  spec.name                  = 'PayByBank'
  spec.version               = "1.0.0"
  spec.author                = { 'Ecospend Technologies Limited' => 'hello@ecospend.com' }
  spec.homepage              = 'https://ecospend.com'
  spec.summary               = 'PayByBank SDK for iOS'
  spec.license               = { :type => 'Apache License, Version 2.0' }
  spec.source                = { :git => 'https://github.com/ecospend/PayByBankSDK-iOS.git', :tag => '1.0.0' }
  spec.ios.deployment_target = '10.3'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'
  spec.pod_target_xcconfig   = {'ENABLE_BITCODE' => 'YES'}
  spec.default_subspec       = 'PayByBank'
  
  spec.subspec 'PayByBank' do |core|
    core.source_files = '**/Sources/PayByBank/**/*.{swift,h,m}'
    core.resources    = '**/Sources/PayByBank/Resources/**/*.{storyboard,xib,strings,xcassets,json,png}'
  end
end
