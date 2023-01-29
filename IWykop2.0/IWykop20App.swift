//
//  iWykop20App.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 27/01/2023.
//

import SwiftUI
import DBDebugToolkit

@main
struct IWykop20App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init(){
        let shakeTrigger = DBShakeTrigger()
        DBDebugToolkit.setup(with: [shakeTrigger])
    }
}
