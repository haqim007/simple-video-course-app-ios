//
//  CourseService.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

class CourseService{
    let config: APIConfig
    init(config: APIConfig) {
        self.config = config
    }
    func getCourse(
        completion: @escaping(Result<[CourseResponse], CustomError>
    ) -> Void) throws {
        config.fetch(type: [CourseResponse].self, completion: completion)
    }
}
