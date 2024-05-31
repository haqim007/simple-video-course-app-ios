//
//  CourseDetailVM.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

class CourseDetailVM: ObservableObject{
    private let repository: CourseRepositoryProtocol
    init(repository: CourseRepositoryProtocol) {
        self.repository = repository
    }
    
    @Published private(set) var course: Resource<Course?, CustomError> = .idle
    
    func getCourses(title: String){
        do{
            try repository.getCourse(title: title){result in
                self.course = result
            }
        }catch let error{
            course = .error(.custom(message: error.localizedDescription), data: nil)
        }
    }
}
