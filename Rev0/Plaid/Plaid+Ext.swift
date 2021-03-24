//
//  Plaid+Ext.swift
//  Rev0
//
//  Created by Luann Dias on 3/22/21.
//

import Foundation
import LinkKit
import FirebaseFunctions

extension BankAccountsVC {
    
    func presentPlaidLinkUsingLinkToken() {
        
        PlaidAPI.createLinkToken { [weak self] (token) in
            
            guard let self = self else { return }
            
            guard let token = token , !token.isEmpty else { return }

            var linkConfiguration = LinkTokenConfiguration(token: token) { (success) in
                print(success.publicToken)
                print(success.metadata)
            }
            
            linkConfiguration.onExit = { exit in
                if let error = exit.error {
                    debugPrint(error.localizedDescription, exit.metadata)
                } else {
                    debugPrint(exit.metadata)
                }
            }
            

            let presenter = Plaid.create(linkConfiguration)
            switch(presenter) {
            case .failure(let error):
                debugPrint(error.localizedDescription)
                //self.simpleAlert(msg: error.localizedDescription)
                
            case .success(let handler):
                handler.open(presentUsing: .viewController(self))
                self.linkHandler = handler
            }
        }
    }
    
    func handleSuccessWithToken(_ publicToken: String, metadata: SuccessMetadata) {
        
    }
}
