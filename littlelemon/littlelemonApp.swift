//
//  littlelemonApp.swift
//  littlelemon
//
//  Created by Michael Woodard on 15/03/23.
//

import SwiftUI

@main
struct littlelemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
        }
    }
}
