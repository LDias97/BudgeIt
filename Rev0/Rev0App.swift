import SwiftUI

@main
struct Rev0App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup{
            MotherView().environmentObject(viewRouter)
        }
    }
}
