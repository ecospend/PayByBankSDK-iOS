import UIKit
import Flutter
import PaylinkSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    PaylinkSDK.shared.configure(.sandbox,
                                          clientID: "910162c0-a0e6-40b8-b66d-f6a9d56bee0f",
                                          clientSecret: "c7667cce1d82212b39090e697e6cf1a300453d8af730ccce0878307b9fb43034")
    PaylinkFlutterModule.shared.start()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
