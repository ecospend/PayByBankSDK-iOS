Pod::Spec.new do |spec|
  spec.name                  = 'PaylinkMobileSDK-iOS'
  spec.version               = "1.0"
  spec.author                = { 'Ecospend Technologies Limited' => 'berk.akkerman@ecospend.com' }
  spec.homepage              = 'https://ecospend.com'
  spec.summary               = 'Paylink SDK for iOS'
  spec.license               = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  spec.source                = { :git => 'https://ecospend@dev.azure.com/ecospend/PaylinkMobileSDK/_git/PaylinkMobileSDK-iOS', :branch => 'develop' }
  spec.ios.deployment_target = '10.3'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'
  spec.source_files          = '**/PaylinkMobileSDK-iOS/PaylinkMobileSDK-iOS/Sources/**/*.{swift, h, m}'
  spec.resources             = "**/PaylinkMobileSDK-iOS/PaylinkMobileSDK-iOS/Sources/PaylinkMobileSDK-iOS/Resources/*.xib"
  spec.pod_target_xcconfig   = {'ENABLE_BITCODE' => 'NO'}
end
