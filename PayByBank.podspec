Pod::Spec.new do |spec|
  spec.name                  = 'PayByBank'
  spec.version               = "1.1.0"
  spec.author                = { 'Ecospend Technologies Limited' => 'hello@ecospend.com' }
  spec.homepage              = 'https://github.com/ecospend/PayByBankSDK-iOS'
  spec.summary               = 'PayByBank SDK is an alternative and easier form of Open Banking solutions.'
  spec.license               = { :type => 'Apache License, Version 2.0' }
  spec.source                = { :git => 'https://github.com/ecospend/PayByBankSDK-iOS.git', :tag => spec.version }
  spec.documentation_url     = 'https://ecospend.github.io/PayByBankSDK-iOS'
  spec.ios.deployment_target = '11.0'
  spec.swift_version         = '5.0'
  spec.default_subspec       = 'PayByBank'
  
  spec.subspec 'PayByBank' do |core|
    core.source_files = '**/Sources/PayByBank/**/*.{swift,h,m}'
    core.resources    = '**/Sources/PayByBank/Resources/**/*.{storyboard,xib,strings,xcassets,json,png}'
  end
end
