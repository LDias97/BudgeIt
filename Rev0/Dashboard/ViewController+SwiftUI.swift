import UIKit
import SwiftUI
import LinkKit

extension ViewController {
    func presentSwiftUILinkToken() {
        PlaidAPI.createLinkToken { [weak self] (linkToken) in
            
            guard let self = self else { return }

            guard let linkToken = linkToken , !linkToken.isEmpty else { return }

            var configuration = LinkTokenConfiguration(token: linkToken) { (success) in
                print("public-token: \(success.publicToken) metadata: \(success.metadata)")

            }
            configuration.onExit = { exit in
                if let error = exit.error {
                    debugPrint(error.localizedDescription, exit.metadata)
                } else {
                    debugPrint(exit.metadata)
                }
            }
            self.presentLink(with: .linkToken(configuration))
        }
    }
    
    func presentSwiftUIPublicKey() {
        let configuration = createPublicKeyConfiguration()
        presentLink(with: .publicKey(configuration))
    }
    
    private func presentLink(with linkConfiguration: LinkController.LinkConfigurationType) {
        let contentView = LinkController(configuration: linkConfiguration, openOptions: [:]) { (error) in
            print("Handle error: \(error)!")
        }
        let vc = UIHostingController(rootView: contentView)
        present(vc, animated: true, completion: nil)
    }
}

