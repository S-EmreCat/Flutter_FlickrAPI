import UIKit
import Flutter
import GoogleMaps



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool { 
    GMSServices.provideAPIKey("AIzaSyAGJQZyHnPgq7GU932hfnQInBsPIY4r0BQ")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
