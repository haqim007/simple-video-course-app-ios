//
//  CourseDetailView.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import SwiftUI
import AVKit

struct CourseDetailView: View {
    @StateObject private var viewModel: CourseDetailVM = provideCourseDetailVM()
    let course: Course
    
    @State private var player = AVPlayer()
    @State var showFullscreen = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack {
                VideoPlayer(player: player){
                    if !showFullscreen {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                                        .padding(16)
                                        .foregroundStyle(.white)
                                        .tint(.white)
                                        .onTapGesture {
                                            showFullscreen.toggle()
                                        }
                                    
                                }
                            }
                        }
                    }
                    .frame(height: 200, alignment: .center)
                    .onAppear {
                        player = AVPlayer(url: self.course.videoURL)
                        player.play()
                        
                    }
                    .onDisappear {
                        player.pause()
                    }
            }
            
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(course.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text("Description")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.top)
                Text(course.description)
                    .font(.subheadline)
                
                Text("Duration")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.top)
                CourseDurationView(duration: course.videoDuration)
                
                Text("Presenter")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.top)
                Text(course.presenterName)
                    .font(.subheadline)
            }
            
            .padding(.all, 8)
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showFullscreen, content: {
            VideoPlayer(player: player){
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .padding(16)
                            .foregroundStyle(.white)
                            .tint(.white)
                            .onTapGesture {
                                showFullscreen.toggle()
                            }
                    }
                    
                }
            }
        })
        .onChange(of: showFullscreen){isFullScreen in
            AppDelegate.orientationLock = isFullScreen ? .landscapeRight : .portrait
        }
    }
}

#Preview {
    CourseDetailView(
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
