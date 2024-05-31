//
//  CourseRepositoryProtocol.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

protocol CourseRepositoryProtocol {
    func getCourses(completion: @escaping (Resource<[Course], CustomError>) -> Void) throws
    func getCourse(title: String, completion: @escaping (Resource<Course?, CustomError>) -> Void) throws
}
