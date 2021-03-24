import UIKit
import Firebase
import LinkKit
import FirebaseFunctions

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
