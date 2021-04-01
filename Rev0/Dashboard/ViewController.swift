import UIKit
import LinkKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var buttonContainerView: UIView!
    var linkHandler: Handler?
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let linkKitBundle  = Bundle(for: PLKPlaid.self)
        let linkKitVersion = linkKitBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        let linkKitBuild   = linkKitBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String)!
        let linkKitName    = linkKitBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String)!
        label.text         = "Swift 5 — \(linkKitName) \(linkKitVersion)+\(linkKitBuild)"
        
        let shadowColor    = #colorLiteral(red: 0.01176470588, green: 0.1921568627, blue: 0.337254902, alpha: 0.1)
        buttonContainerView.layer.shadowColor   = shadowColor.cgColor
        buttonContainerView.layer.shadowOffset  = CGSize(width: 0, height: -1)
        buttonContainerView.layer.shadowRadius  = 2
        buttonContainerView.layer.shadowOpacity = 1
    }
    
    @IBAction func didTapButton(_ sender: Any?) {
        presentSwiftUILinkToken()
    }
    
    func setToken(token: String){
        self.token = token
    }
}

extension ViewController {
    
    func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        let linkToken = self.token!
        var linkConfiguration = LinkTokenConfiguration(token: linkToken) { success in
            print("public-token: \(success.publicToken) metadata: \(success.metadata)")
            self.getAccessToken(publicToken: success.publicToken)
        }
        linkConfiguration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
        }
        return linkConfiguration
    }
    
    func presentPlaidLinkUsingLinkToken() {
        let linkConfiguration = createLinkTokenConfiguration()
        let result = Plaid.create(linkConfiguration)
        switch result {
        case .failure(let error):
            print("Unable to create Plaid handler due to: \(error)")
        case .success(let handler):
            handler.open(presentUsing: .viewController(self))
            linkHandler = handler
        }
    }
    
    func presentSwiftUILinkToken() {
        let configuration = createLinkTokenConfiguration()
        presentLink(with: .linkToken(configuration))
    }
    
    private func presentLink(with linkConfiguration: LinkController.LinkConfigurationType) {
        let contentView = LinkController(configuration: linkConfiguration, openOptions: [:]) { (error) in
            print("Handle error: \(error)!")
        }
        let vc = UIHostingController(rootView: contentView)
        present(vc, animated: true, completion: nil)
    }
    
    func getAccessToken(publicToken: String)
    {
        
        
//        UserDefaults.standard.set(accessToken, forKey: "plaid-access-token")
    }
    
    func setToken(token: String){
        self.token = token
    }
}
