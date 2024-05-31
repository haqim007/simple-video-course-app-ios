//
//  Injection.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

func provideCourseListVM() -> CourseListVM{
    return CourseListVM(repository: provideCourseRepository())
}

func provideCourseDetailVM() -> CourseDetailVM{
    return CourseDetailVM(repository: provideCourseRepository())
}

func provideCourseRepository() -> CourseRepositoryProtocol{
    return CourseRepository(service: provideCourseService(), db: provideCourseDB())
}

func provideCourseService() -> CourseService{
    return CourseService(config: provideAPIConfig())
}

func provideCourseDB() -> CourseDB{
    return try! CourseDB()
}

func provideAPIConfig() -> APIConfig{
    return APIConfig()
}
