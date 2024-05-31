//
//  APIConfig.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

let domain = "https://quipper.github.io/native-technical-exam/playlist.json"

struct APIConfig{
    
    
    internal func processResult<T: Decodable>(type: T.Type, _ error: Error?, _ response: URLResponse?, _ data: Data?, completion: @escaping (Result<T, CustomError>) -> Void) {
        let decoder = JSONDecoder()
        
        if let error = error as? URLError {
            completion(Result.failure(CustomError.url(error)))
        }
        else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
            completion(Result.failure(CustomError.badResponse(statusCode: response.statusCode)))
            
        }else if let data = data{
            do{
                let result = try decoder.decode(type, from: data)
                completion(Result.success(result))
            }catch{
                if let decodingError = error as? DecodingError {
                    // Print the decoding error details
                    print(data.printJSON())
                    print("Decoding Error: \(decodingError)")
                    
                    switch decodingError {
                    case .dataCorrupted(let context):
                        print("Data Corrupted. Context: \(context)")
                        
                    case .keyNotFound(let key, let context):
                        print("Key '\(key)' not found. Context: \(context)")
                        
                    case .typeMismatch(let type, let context):
                        print("Type '\(type)' mismatch. Context: \(context)")
                        
                    case .valueNotFound(let type, let context):
                        print("Value of type '\(type)' not found. Context: \(context)")
                        
                    @unknown default:
                        print("Unknown decoding error occurred.")
                    }
                    
                    completion(Result.failure(CustomError.parsing(decodingError)))
                } else {
                    print(error.localizedDescription)
                    completion(Result.failure(CustomError.parsing(error as? DecodingError)))
                }
            }
        }
    }
    
    private func createRequest(method: HTTPMethod, url: URL, body: Data? = nil) -> URLRequest{

        // To ensure that our request is always sent, we tell
        // the system to ignore all local cache data:
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = method.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        
        if body != nil{
            request.httpBody = body
        }
        
        return request
    }
    
    func fetch<T: Decodable>(type: T.Type, completion: @escaping(Result<T, CustomError>) -> Void){
        guard let url = URL(string: domain) else {
            let errorMesage = CustomError.badURL
            completion(Result.failure(errorMesage))
            return
        }
        let request = createRequest(method: .get, url: url)
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            
            processResult(type: type, error, response, data, completion: completion)
        }

        task.resume()
    }
}
