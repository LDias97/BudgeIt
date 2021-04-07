import Foundation
import SwiftUI
import LinkKit

struct LinkView: View {
    @ObservedObject var plaid = PlaidAPI()
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData

    var body: some View {
        Group {
            if plaid.hasLoaded {
                LinkController(configuration: .linkToken(plaid.vc.createLinkTokenConfiguration()))
                    .onDisappear(){ userData.load(); viewRouter.currentPage = .page3 }
            }
            else {
                Text("Loading Plaid")
            }
        }.onAppear(){
            self.plaid.setToken()
        }
    }
    
}
