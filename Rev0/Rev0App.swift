//
//  Rev0App.swift
//  Rev0
//
//  Created by Ben on 2/17/21.
//

import SwiftUI
import Firebase

@main
struct Rev0App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    @StateObject var bank = BankAccountViewModel()

    
    var body: some Scene {
        WindowGroup{
            MotherView().environmentObject(viewRouter)
                        .environmentObject(bank)
        }
    }
}
