//
//  CourseListItemView.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import SwiftUI

struct CourseListItemView: View {
    let course: Course
    
    let imageHeight: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: course.thumbnailURL) { phase in
                if let image = phase.image {
                    // Displays the loaded image.
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, minHeight: imageHeight)
                        .clipped()
                } else if phase.error != nil {
                    // Indicates an error.
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: imageHeight)
                        .clipped()
                } else {
                    ProgressView()
                        .frame(width: imageHeight/5, height: imageHeight/5)
                }
            }
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                CourseDurationView(duration: course.videoDuration)
                
                Text(course.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(course.description)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(course.presenterName)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .lineLimit(1)
            }
            
            .padding(.vertical, 8)
        }
        .padding()
        .frame(alignment: .top)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .opacity(0.5)
                .foregroundColor(.black)
        )
        .clipShape(RoundedCorner(radius: 10))
        
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CourseDurationView: View {
    let duration: Course.Duration
    
    var body: some View {
        HStack(spacing: 4) {
            Text("\(duration.hour)h")
                .font(.custom("SF Pro Text", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 91/255, green: 161/255, blue: 147/255))
            Text("\(duration.minutes)m")
                .font(.custom("SF Pro Text", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 91/255, green: 161/255, blue: 147/255))
            Text("\(duration.seconds)s")
                .font(.custom("SF Pro Text", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 91/255, green: 161/255, blue: 147/255))
        }
    }
}


#Preview {
    ZStack{
        Color.black
        CourseListItemView(
            course: Course(
                title: "G12 Chemistry",
                presenterName: "Kaoru Sakata",
                description: "90 seconds exercise for Chemistry",
                thumbnailURL: URL(string: "https://quipper.github.io/native-technical-exam/images/sakata.jpg")!,
                videoURL: URL(string: "https://quipper.github.io/native-technical-exam/videos/sakata.mp4")!,
                videoDuration: Course.Duration(
                    hour: 1, minutes: 0, seconds: 0, allInSeconds: 3600)
                )
        )
    }
}
