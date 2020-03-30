import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCNw5Rdu6Ai7Nk_m8-oyLu6Bv0fPqTbYoM")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)

    AppDelegate.m #import <FBSDKCoreKit/FBSDKCoreKit.h> -
     (BOOL)application:(UIApplication *)
     application didFinishLaunchingWithOptions:(NSDictionary *)
     launchOptions { [[FBSDKApplicationDelegate sharedInstance]
     application:application didFinishLaunchingWithOptions:launchOptions]; // Add any custom logic here. return YES; } - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options { BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey] ]; }

    - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
    sourceApplication:(NSString *)
    sourceApplication annotation:(id)
    annotation { BOOL handled = [
    [FBSDKApplicationDelegate sharedInstance]
    application:application openURL:url sourceApplication:sourceApplication annotation:annotation
    ]; // Add any custom logic here. return handled; }
  }
}
