//
//  CourseMapper.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

extension CourseResponse{
    func toEntity() -> CourseEntity{
        return CourseEntity(
            title: self.title,
            presenterName: self.presenterName,
            courseDescription: self.description,
            thumbnailURL: self.thumbnailURL,
            videoURL: self.videoURL,
            videoDuration: self.videoDuration
        )
    }
}

extension Array where Element == CourseResponse{
    func toEntities() -> [CourseEntity]{
        return self.map{data in
            data.toEntity()
        }
    }
}

extension CourseEntity{
    func toModel() -> Course{
        return Course(
            title: self.title,
            presenterName: self.presenterName,
            description: self.courseDescription,
            thumbnailURL: URL(string: self.thumbnailURL)!,
            videoURL: URL(string: self.videoURL)!,
            videoDuration: secondsToDuration(totalSeconds: self.videoDuration)
        )
    }
}

extension Array where Element == CourseEntity{
    func toModels() -> [Course]{
        return self.map{data in
            data.toModel()
        }
    }
}

func secondsToDuration(totalSeconds: Int) -> Course.Duration {
    let hour = totalSeconds / 3600
    let remainingSecondsAfterHour = totalSeconds % 3600
    let minutes = remainingSecondsAfterHour / 60
    let seconds = remainingSecondsAfterHour % 60

    return Course.Duration(hour: hour, minutes: minutes, seconds: seconds, allInSeconds: totalSeconds)
}
