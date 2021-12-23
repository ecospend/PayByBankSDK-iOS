Pod::Spec.new do |spec|
  spec.name                  = 'PaylinkSDK'
  spec.version               = "1.0"
  spec.author                = { 'Ecospend Technologies Limited' => 'hello@ecospend.com' }
  spec.homepage              = 'https://ecospend.com'
  spec.summary               = 'Paylink SDK for iOS'
  spec.license               = { :type => 'Apache License, Version 2.0' }
  spec.source                = { :git => 'https://ecospend@dev.azure.com/ecospend/PaylinkMobileSDK/_git/PaylinkMobileSDK-iOS', :branch => 'develop' }
  spec.ios.deployment_target = '10.3'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'
  spec.source_files          = '**/PaylinkSDK/Sources/**/*.{swift, h, m}'
  spec.resources             = "**/PaylinkSDK/Sources/Resources/*.xib"
  spec.pod_target_xcconfig   = {'ENABLE_BITCODE' => 'NO'}
end
