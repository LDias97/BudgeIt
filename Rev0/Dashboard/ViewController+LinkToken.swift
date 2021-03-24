import LinkKit
import FirebaseFunctions

extension ViewController {
    
    func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        
        var linkToken = "GENERATED_LINK_TOKEN"

        Functions.functions().httpsCallable("createPlaidLinkToken").call() { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            if let token = result?.data as? String {
                linkToken = token
            }
        }

        var linkConfiguration = LinkTokenConfiguration(token: linkToken) { success in
            print("public-token: \(success.publicToken) metadata: \(success.metadata)")
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
            print("worked")
            handler.open(presentUsing: .viewController(self))
            linkHandler = handler
        }
    }
}
