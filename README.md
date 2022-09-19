# PayByBank SDK (iOS)

[![CocoaPods compatible](https://img.shields.io/cocoapods/v/PayByBank.svg)](https://cocoapods.org/pods/PaybyBank)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/ios)](https://img.shields.io/cocoapods/p/ios)
[![Swift](https://img.shields.io/badge/Swift-5-orange?style=flat)](https://img.shields.io/badge/Swift-5-orange?style=flat)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

The Ecospend Gateway presents PayByBank SDK as an alternative and easier form of Open Banking Instant Payment solutions. PayByBank SDK provides you the option of downsizing the development effort for a PIS and AIS journeys to a single SDK integration. PayByBank undertakes all of interaction in the payment user journey with your branding on display.

PayByBank SDK includes solutions of:

- [Paylink](https://docs.ecospend.com/api/paylink/V2/#tag/Paylink-API) provides to execute the payment order.
- [FrPayment](https://docs.ecospend.com/api/paylink/V2/#tag/FrPayments-API) provides to execute a standing order.
- [BulkPayment](https://docs.ecospend.com/api/paylink/V2/#tag/Bulk-Paymentlink-API) provides to execute the Bulk Payment order.
- [VRPlink](https://docs.ecospend.com/api/paylink/V2/#tag/Vrplink-API) provides to execute the Variable Recurring Payments consent.
- [Datalink](https://docs.ecospend.com/api/ais/V2/#tag/Datalink-API) is a whitelabel consent journey solution provided by Ecospend that downsizes the required implementation for the consent journey to a single endpoint integration.
- [Payment](https://docs.ecospend.com/api/pis/V2/#tag/Payments-API) provides to execute the domestic instant payments, international payments, and scheduled payments.

## Requirements

- iOS 11.0+
- Swift 5.0+

## Installation

### CocoaPods

To integrate PayByBank into your Xcode project using CocoaPods, add this to your `Podfile`:

```
pod 'PayByBank', :git => 'https://github.com/ecospend/PayByBankSDK-iOS.git', :tag => '2.0.0'

# or

pod 'PayByBank', '2.0.0'
```

Then run `pod install`.

### Swift Package Manager

#### User Interface

To integrate using Apple's Swift package manager, with Xcode integration, apply the following steps:

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/ecospend/PayByBankSDK-iOS.git`
- Select "Dependency Rule" with "Exact Version" and "2.0.0"

#### Manually

To integrate using Apple's Swift package manager, without Xcode integration, add the following as a dependency to your `Package.swift`

```
.package(url: "https://github.com/ecospend/PayByBankSDK-iOS.git", from: "2.0.0")
```

### Carthage

To integrate PayByBank into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "ecospend/PayByBankSDK-iOS" ~> 2.0.0
```

Then run `carthage update --use-xcframeworks` and drag the built `PayByBank.xcframework` bundle from `Carthage/Build` into the "Frameworks and Libraries" section of your application’s Xcode project.

## Documentation

To get more information about PayByBank, check out the [documentation](https://ecospend.github.io/PayByBankSDK-iOS).

## Usage

*Note: Please look at [API Specifications & Developer's Guide](https://docs.ecospend.com/api/intro) for more details.*

After creating a link ([Paylink](https://docs.ecospend.com/api/paylink/V2/#tag/Paylink-API), [FrPayment](https://docs.ecospend.com/api/paylink/V2/#tag/FrPayments-API), [BulkPayment](https://docs.ecospend.com/api/paylink/V2/#tag/Bulk-Paymentlink-API), [VRPlink](https://docs.ecospend.com/api/paylink/V2/#tag/Vrplink-API), [Datalink](https://docs.ecospend.com/api/ais/V2/#tag/Datalink-API), [Payment](https://docs.ecospend.com/api/pis/V2/#tag/Payments-API)),  PayByBank SDK provides to manage easily client-side web view flows, when necessary parameters are passed.

```
PayByBank.open(paylink uniqueID: String, url: URL, redirectURL: URL, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void)

// or

PayByBank.open(frPayment uniqueID: String, url: URL, redirectURL: URL, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void)

// or

PayByBank.open(vrplink uniqueID: String, url: URL, redirectURL: URL, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void)

// or

PayByBank.open(bulkPayment uniqueID: String, url: URL, redirectURL: URL, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void)

// or

PayByBank.open(datalink uniqueID: String, url: URL, redirectURL: URL, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void)

// or

PayByBank.open(payment id: String, url: URL, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void)
```


## Sample Projects

We have provided a sample project in the repository. Source files for these are in the `Examples` directory in the project navigator.

## License

PayByBank SDK is released under the [Apache License](https://github.com/ecospend/PayByBankSDK-iOS/blob/master/LICENSE).