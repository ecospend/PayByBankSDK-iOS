Pod::Spec.new do |spec|
  spec.name                  = 'Paylink'
  spec.version               = "1.0"
  spec.author                = { 'Ecospend Technologies Limited' => 'hello@ecospend.com' }
  spec.homepage              = 'https://ecospend.com'
  spec.summary               = 'Paylink SDK for iOS'
  spec.license               = { :type => 'Apache License, Version 2.0' }
  spec.source                = { :git => 'https://ecospend@dev.azure.com/ecospend/PaylinkMobileSDK/_git/PaylinkMobileSDK-iOS', :branch => 'develop' }
  spec.ios.deployment_target = '10.3'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'
  spec.pod_target_xcconfig   = {'ENABLE_BITCODE' => 'YES'}
  spec.default_subspec       = 'Core'
  
  spec.subspec 'Core' do |core|
    core.source_files = '**/Paylink/Sources/Core/**/*.{swift,h,m}'
    core.resources    = '**/Paylink/Sources/Core/Resources/**/*.{storyboard,xib,strings,xcassets,json,png}'
  end
  
  spec.subspec 'React' do |rn|
    rn.source_files = '**/Paylink/Sources/React/**/*.{m,swift}'
    rn.dependency 'React'
    rn.dependency 'Paylink/Core'
  end
  
  spec.subspec 'Flutter' do |fl|
    fl.source_files = '**/Paylink/Sources/Flutter/**/*.{m,swift}'
    fl.dependency 'Flutter'
    fl.dependency 'Paylink/Core'
  end
  
end
