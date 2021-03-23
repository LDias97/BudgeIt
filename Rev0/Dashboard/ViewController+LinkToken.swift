//
//  ViewController+LinkToken.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//

import LinkKit

extension ViewController {

    func createLinkTokenConfiguration() -> LinkTokenConfiguration {

        let linkToken = "<#GENERATED_LINK_TOKEN#>"

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

    // MARK: Start Plaid Link using a Link token
    // For details please see https://plaid.com/docs/#create-link-token
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
}
