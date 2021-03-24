//
//  BankAccountsManager.swift
//  Rev0
//
//  Created by Luann Dias on 3/22/21.
//

import Foundation
import SwiftUI

struct BankAccountsManager: View {

    var body: some View {
        VStack() {
            Text("SwiftUI in BankAccountsManager")
            List {
                Text("Bank of America")
            }
        }
    }
}


struct BankAccountsManager_Previews: PreviewProvider {
    static var previews: some View {
        BankAccountsManager()
    }
}
