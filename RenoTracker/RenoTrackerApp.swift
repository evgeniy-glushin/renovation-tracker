//
//  RenoTrackerApp.swift
//  RenoTracker
//
//  Created by User on 08.01.2023.
//

import SwiftUI

@main
struct RenoTrackerApp: App {
    private var projectsPublisher = RenovationProjectsPublisher()
    
    var body: some Scene {
        WindowGroup {
            RenovationProjectsView(projectsPublisher: projectsPublisher)
        }
    }
}
