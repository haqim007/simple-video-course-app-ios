//
//  Course.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

struct Course: Identifiable {
    let id: UUID = UUID()
    let title, presenterName, description: String
    let thumbnailURL: URL
    let videoURL: URL
    let videoDuration: Duration
    
    struct Duration{
        let hour: Int
        let minutes: Int
        let seconds: Int
        let allInSeconds: Int
    }
}
