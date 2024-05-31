//
//  CourseEntity.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation
import SwiftData

@Model
class CourseEntity {
    @Attribute(.unique) var title: String
    var presenterName: String
    var courseDescription: String
    var thumbnailURL: String
    var videoURL: String
    var videoDuration: Int
    
    init(title: String, presenterName: String, courseDescription: String, thumbnailURL: String, videoURL: String, videoDuration: Int) {
        self.title = title
        self.presenterName = presenterName
        self.courseDescription = courseDescription
        self.thumbnailURL = thumbnailURL
        self.videoURL = videoURL
        self.videoDuration = videoDuration
    }
    
    
}
