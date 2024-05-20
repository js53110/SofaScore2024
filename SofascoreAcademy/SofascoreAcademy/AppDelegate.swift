import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let loadingViewController = LoadingViewController()
        window?.rootViewController = UINavigationController(rootViewController: loadingViewController)
        self.window?.makeKeyAndVisible()

        return true
    }


}

