import SwiftUI

@main
struct Rev0App: App {
    
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup{
            MotherView().environmentObject(viewRouter)
        }
    }
}
