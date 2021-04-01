import Foundation
import SwiftUI
import LinkKit

struct LinkView: View {
    @ObservedObject var token = Token()
//    @Binding var accessToken: String
//    let publicKey: String
    
    var body: some View {
        Group{
            if token.hasLoaded {
                LinkController(configuration: .linkToken(token.vc.createLinkTokenConfiguration()))
                
            }
            else {
                Text("Loading Plaid")
            }
        }.onAppear(){
            self.token.setToken()
        }
    }
    
}
