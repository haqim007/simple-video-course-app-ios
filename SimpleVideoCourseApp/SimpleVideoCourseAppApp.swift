//
//  SimpleVideoCourseAppApp.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import SwiftUI
import SwiftData

@main
struct SimpleVideoCourseAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CourseEntity.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CourseListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
