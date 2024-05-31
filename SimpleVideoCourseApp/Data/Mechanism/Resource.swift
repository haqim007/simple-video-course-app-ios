//
//  Resource.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

enum Resource<ResultType, ErrorType> where ErrorType : Error {
    case success(_ data: ResultType)
    case loading(_ data: ResultType? = nil)
    case error(_ error: ErrorType, data: ResultType? = nil)
    case idle
}

extension Resource where ErrorType: Error {
    func getData() -> ResultType? {
        if case let .success(data) = self {
            return data
        } else if case let .error(_, data) = self {
            return data
        }
        
        return nil
    }
    
    func replaceData(newData: ResultType) -> Resource<ResultType, ErrorType>{
        switch self {
        case .success(_):
            return .success(newData)
        case .loading(_):
            return .loading(newData)
        case .error(let error, _):
            return .error(error, data: newData)
        case .idle:
            return .idle
        }
    }
}
