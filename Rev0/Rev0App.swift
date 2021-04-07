import SwiftUI
import Firebase

@main
struct Rev0App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    @StateObject var userData = UserData()

    
    var body: some Scene {
        WindowGroup{
            MotherView().environmentObject(viewRouter)
                        .environmentObject(userData)
        }
    }
}
