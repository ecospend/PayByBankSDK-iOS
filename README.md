# PayByBank SDK (iOS)

[![CocoaPods compatible](https://img.shields.io/cocoapods/v/PayByBank.svg)](https://cocoapods.org/pods/PaybyBank)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/ios)](https://img.shields.io/cocoapods/p/ios)
[![Swift](https://img.shields.io/badge/Swift-5-orange?style=flat)](https://img.shields.io/badge/Swift-5-orange?style=flat)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

The Ecospend Gateway presents PayByBank SDK as an alternative and easier form of Open Banking Instant Payment solutions. PayByBank SDK provides you the option of downsizing the development effort for a PIS and AIS journeys to a single SDK integration. PayByBank undertakes all of interaction in the payment user journey with your branding on display.

- `Paylink` provides to execute the payment order.
- `FrPayment` provides to execute a standing order.
- `BulkPayment` provides to execute the Bulk Payment order.
- `VRPlink` provides to execute the Variable Recurring Payments consent.
- `Datalink` is a whitelabel consent journey solution provided by Ecospend that downsizes the required implementation for the consent journey to a single endpoint integration.
- `Payment` provides to execute the domestic instant payments, international payments, and scheduled payments.

## Requirements

- iOS 11.0+
- Swift 5.0+

## Installation

### CocoaPods

To integrate PayByBank into your Xcode project using CocoaPods, add this to your `Podfile`:

```
pod 'PayByBank', :git => 'https://github.com/ecospend/PayByBankSDK-iOS.git', :tag => '1.1.0'

# or

pod 'PayByBank', '1.1.0'
```

Then run `pod install`.

### Swift Package Manager

#### User Interface

To integrate using Apple's Swift package manager, with Xcode integration, apply the following steps:

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/ecospend/PayByBankSDK-iOS.git`
- Select "Dependency Rule" with "Exact Version" and "1.1.0"

#### Manually

To integrate using Apple's Swift package manager, without Xcode integration, add the following as a dependency to your `Package.swift`

```
.package(url: "https://github.com/ecospend/PayByBankSDK-iOS.git", from: "1.1.0")
```

### Carthage

To integrate PayByBank into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "ecospend/PayByBankSDK-iOS" ~> 1.1.0
```

Then run `carthage update --use-xcframeworks` and drag the built `PayByBank.xcframework` bundle from `Carthage/Build` into the "Frameworks and Libraries" section of your application’s Xcode project.

## Documentation

To get more information about PayByBank, check out the [documentation](https://ecospend.github.io/PayByBankSDK-iOS).

## Usage

*Note: Please look at [API Specifications & Developer's Guide](https://docs.ecospend.com/api/intro) for more details.*

### Onboarding

To start using our API, you need to onboard with us and get a Client Id (`client_id`) and Client Secret (`client_secret`) via email to <support@ecospend.com>. For onboarding we will need the following information:

- The full name of your company/organization
- An email address for your admin user (used as username)
- A mobile phone number for the admin user (used for two-factor authentication)

Once onboarded, a Client Id is generated for you and you will have access to our Management Console, through which you can generate your Client Secret(s).

- The `client_id` is created by Ecospend when your organization is registered with us.
- The `client_secret` is a security key that your administrator should create from the Management Console. This is not visible to or accessible  by the Ecospend team. Therefore, you should store it safely.
- The `access_token` is required for all subsequent requests to the API. You should keep it safe and secure during its lifetime. The lifetime is configurable.

You will be given separate pairs of Client Id and Client Secret for our `Sandbox` and `Production` environments respectively. Ecospend does not store these parameters; therefore, you need to keep them safe and secure.

- `Sandbox` environment should be used for testing purposes.
- `Production` environment should be used for released applications.

### Authentication

PayByBank SDK supports [Token-Based Authentication](https://en.wikipedia.org/wiki/Access_token) to access Ecospend Gateway APIs.

`PayByBank.configure` function should be called to access `access_token` before using APIs which requires authentication of PayByBank SDK. When `access_token` is expired, `PayByBank.configure` function should be called again. To generate `access_token`, check out the [Get Access Token](https://docs.ecospend.com/api/intro/#tag/Get-Access-Token) documentation.

```
PayByBank.configure(environment: <environment>)

// or

PayByBank.configure(environment: <environment>, 
                    accessToken: <accessToken>,
                    tokenType: <tokenType>)
```

## Sample Projects

We have provided a sample project in the repository. Source files for these are in the `Examples` directory in the project navigator.

## License

PayByBank SDK is released under the [Apache License](LICENSE).