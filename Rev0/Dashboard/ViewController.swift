import UIKit
import LinkKit

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
