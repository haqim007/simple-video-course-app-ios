//
//  CourseRepository.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation
import SwiftData

class CourseRepository: CourseRepositoryProtocol{
    
    
    private let service: CourseService
    private let db: CourseDB
    
    init(service: CourseService, db: CourseDB) {
        self.service = service
        self.db = db
    }
    
    private func getCachedCourses() throws -> [CourseEntity] {
        let context = ModelContext(db.container)
        let fetchDescriptor = FetchDescriptor<CourseEntity>(
                predicate: nil,
                sortBy: []
            )
        return try context.fetch(fetchDescriptor)
    }
    
    private func getCachedCourse(title: String) throws -> CourseEntity? {
        let context = ModelContext(db.container)
        let fetchDescriptor = FetchDescriptor<CourseEntity>(
                predicate: #Predicate { $0.title == title },
                sortBy: []
            )
        return try context.fetch(fetchDescriptor).first
    }
    
    private func saveCourses(courses: [CourseEntity]) throws{
        let context = ModelContext(db.container)
        try context.transaction {
            for course in courses {
                context.insert(course)
            }
            try context.save()
        }
    }
    
    private func resetCoursesCache() throws {
        let context = ModelContext(db.container)
        try context.delete(model: CourseEntity.self)
        try context.save()
    }
    
    private func refreshCourses(courses: [CourseEntity]) throws -> [Course]{
        let context = ModelContext(db.container)
        try context.transaction {
            // reset
            try self.resetCoursesCache()
            // save
            try self.saveCourses(courses: courses)
        }
        // return
        return try self.getCachedCourses().toModels()
        
    }
    
    func getCourses(
        completion: @escaping (Resource<[Course], CustomError>) -> Void
    ) {
        
        do{
            completion(.loading())
            try service.getCourse{ result in
                do{
                    switch result{
                    case .success(let resData):
                        let result = resData.toEntities()
                        completion(.success(try self.refreshCourses(courses: result)))
                    case .failure(let err):
                        completion(.error(err))
                        print(err.description)
                        
                    }
                }catch let error{
                    completion(.error(CustomError.custom(message: error.localizedDescription)))
                }
                
            }
        }
        catch let error{
            completion(.error(CustomError.custom(message: error.localizedDescription)))
        }
    }
    
    func getCourse(title: String, completion: @escaping (Resource<Course?, CustomError>) -> Void) throws {
        do{
            completion(.loading())
            let course = try self.getCachedCourse(title: title)
            completion(.success(course?.toModel()))
        }
        catch let error{
            completion(.error(CustomError.custom(message: error.localizedDescription)))
        }
    }
    
    
}
