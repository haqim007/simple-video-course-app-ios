//
//  CourseResponse.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

struct CourseResponse: Codable {
    let title, presenterName, description: String
    let thumbnailURL: String
    let videoURL: String
    let videoDuration: Int

    enum CodingKeys: String, CodingKey {
        case title
        case presenterName = "presenter_name"
        case description
        case thumbnailURL = "thumbnail_url"
        case videoURL = "video_url"
        case videoDuration = "video_duration"
    }
}
