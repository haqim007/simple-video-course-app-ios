//
//  CourseListView.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import SwiftUI

struct CourseListView: View {
    @StateObject private var viewModel: CourseListVM = provideCourseListVM()
    var body: some View {
        NavigationStack{
            ScrollView{
                switch viewModel.courses {
                case .success(let data):
                    LazyVStack{
                        ForEach(data){course in
                            NavigationLink {
                                CourseDetailView(course: course)
                            } label: {
                                CourseListItemView(course: course)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                case .error(let error, let data):
                    if (data == nil || data!.isEmpty){
                        ListEmptyView(
                            message: error.localizedDescription,
                            onReload: {}
                        )
                    }else{
                        LazyVStack{
                            ForEach(data!){course in
                                NavigationLink {
                                    CourseDetailView(course: course)
                                } label: {
                                    CourseListItemView(course: course)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                default:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Courses")
            .onAppear{
                viewModel.getCourses()
            }
        }
    }
}

#Preview {
    CourseListView()
}

struct ListEmptyView: View {
    
    var message: String = "Error occured"
    var onReload: (() -> Void)? = nil
    var body: some View {
        VStack{
            Image(systemName: "exclamationmark.triangle")
            HStack{
                Text(message)
                  .multilineTextAlignment(.center)
                  .foregroundColor(.black.opacity(0.5))
                  
            }.padding(.top, 10)
            
            if onReload != nil{
                Button(action: {
                    self.onReload!()
                }){
                    Label("Retry", systemImage: "arrow.uturn.backward.circle")
                }.padding(.top, 16)
            }
        }
    }
}
