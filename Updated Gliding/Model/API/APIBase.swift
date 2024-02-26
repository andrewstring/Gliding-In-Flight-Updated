//
//  APIBase.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import CoreLocation

struct APIBase {
    enum RequestType: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }

    static func getRequest<T: Decodable>(path: String, responseType: T.Type) {
        let url: URL = URL(string: "\(APIConfig.url):\(APIConfig.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.GET.rawValue
        
        // Get request does not have a body
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) {(dataOpt, response, error) in
            if error != nil {
                guard let data = dataOpt else { return }
                guard let decodedData = try? JSONDecoder().decode(responseType, from: data) else { return }
                print("DECODED DATA")
                print(decodedData)
            }
        }
    }
    
    static func postRequest<T: Decodable>(path: String, responseType: T.Type, requestData: Encodable) throws {
        let url: URL = URL(string: "\(APIConfig.url):\(APIConfig.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.POST.rawValue
        
        guard let bodyData = try? JSONEncoder().encode(requestData) else { throw APIError.PostRequestInvalidRequestData }
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) {(dataOpt, response, error) in
            if error != nil {
                guard let data = dataOpt else { return }
                guard let decodedData = try? JSONDecoder().decode(responseType, from: data) else { return }
                print("DECODED DATA")
                print(decodedData)
            }
        }
    }
    
    static func putRequest<T: Decodable>(path: String, responseType: T.Type, requestData: Encodable) throws {
        let url: URL = URL(string: "\(APIConfig.url):\(APIConfig.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.PUT.rawValue
        
        guard let bodyData = try? JSONEncoder().encode(requestData) else { throw APIError.PutRequestInvalideRequestData }
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) {(dataOpt, response, error) in
            if error != nil {
                guard let data = dataOpt else { return }
                guard let decodedData = try? JSONDecoder().decode(responseType, from: data) else { return }
                print("DECODED DATA")
                print(decodedData)
            }
        }
    }
    
    static func deleteRequest<T: Decodable>(path: String, responseType: T.Type, requestData: Encodable) throws {
        let url: URL = URL(string: "\(APIConfig.url):\(APIConfig.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.DELETE.rawValue
        
        // Delete request does not have a body
        guard let bodyData = try? JSONEncoder().encode(requestData) else { throw APIError.DeleteRequestInvalideRequestData }
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) {(dataOpt, response, error) in
            if error != nil {
                guard let data = dataOpt else { return }
                guard let decodedData = try? JSONDecoder().decode(responseType, from: data) else { return }
                print("DECODED DATA")
                print(decodedData)
            }
        }
    }
}
