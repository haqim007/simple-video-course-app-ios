//
//  CourseDB.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import SwiftData

final class CourseDB {
    
    let container: ModelContainer
    
    init() throws {
        container = try ModelContainer(for: CourseEntity.self)
    }
}
