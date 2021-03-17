//
//  Rev0App.swift
//  Rev0
//
//  Created by Ben on 2/17/21.
//

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
