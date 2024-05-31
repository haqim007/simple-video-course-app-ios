//
//  CustomError.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

enum CustomError: Error, CustomStringConvertible{
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    case encodeParsing(EncodingError?)
    case custom(message: String)
    
    // For user feedback
    var localizedDescription: String {
        switch self{
        case .badURL, .parsing, .unknown, .encodeParsing:
            return "Something went wrong"
        case .badResponse(_):
            return "Failed to connect to server"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        case .custom(let message):
            return message
        }
    }
    
    //For debugging purpose
    var description: String {
        switch self{
        case .encodeParsing(let error): return "encode parsing error. \(error?.localizedDescription ?? "")"
        case .unknown:
            return "unkown error"
        case .badURL: return "invalid url"
        case .url (let error): return error?.localizedDescription ?? "url session error"
        case .parsing(let error): return "parsing error. \(error?.localizedDescription ?? "")"
        case .badResponse(let statusCode): return "bad response with status code: \(statusCode)"
        case .custom(let message): return message
        }
    }
}
