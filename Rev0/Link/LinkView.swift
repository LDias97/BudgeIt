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
                    .onDisappear(){ if(plaid.vc.didSetUp) { userData.load(); viewRouter.currentPage = .page3 } }
            }
        }.onAppear(){
            self.plaid.setToken()
        }
    }
    
}
