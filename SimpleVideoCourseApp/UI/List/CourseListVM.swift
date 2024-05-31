//
//  CourseListVM.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

class CourseListVM: ObservableObject{
    private let repository: CourseRepositoryProtocol
    init(repository: CourseRepositoryProtocol) {
        self.repository = repository
    }
    
    @Published private(set) var courses: Resource<[Course], CustomError> = .idle
    
    func getCourses(){
        do{
            try repository.getCourses{result in
                DispatchQueue.main.async{
                    self.courses = result
                }
            }
        }catch let error{
            courses = .error(.custom(message: error.localizedDescription), data: nil)
        }
    }
}
