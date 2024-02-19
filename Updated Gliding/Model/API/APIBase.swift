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
        let url: URL = URL(string: "\(Config.url):\(Config.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.GET.rawValue
        
        // Get request does not have a body
        request.httpBody = nil
        
        let task = URLSession.shared.dataTask(with: request) {(dataOpt, response, error) -> Void in
            guard let data = dataOpt else { return }
            guard let decodedData = try? JSONDecoder().decode(responseType, from: data) else { return }
            print(decodedData)
        }
        task.resume()
    }
    
    static func postRequest<T: Decodable>(path: String, responseType: T.Type, requestData: Encodable) {
        let url: URL = URL(string: "\(Config.url):\(Config.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.POST.rawValue
        
        guard let bodyData = try? JSONEncoder().encode(requestData) else { return }
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) {(dataOpt, respone, error) -> Void in
            guard let data = dataOpt else { return }
            guard let decodedData = try? JSONDecoder().decode(responseType, from: data) else { return }
            print(decodedData)
        }
        task.resume()
    }
    
    static func putRequest(path: String, data: Encodable) {
        let url: URL = URL(string: "\(Config.url):\(Config.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.PUT.rawValue
        
        let bodyDataOpt: Data? = try? JSONEncoder().encode(data)
        guard let bodyData = bodyDataOpt else { return }
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) {(dataOpt, response, error) -> Void in
            guard let data = dataOpt else { return }
            print(data)
            return
        }
        task.resume()
    }
    
    static func deleteRequest(path: String, data: Encodable? = nil) {
        let url: URL = URL(string: "\(Config.url):\(Config.port)\(path)")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = RequestType.DELETE.rawValue
        
        // Delete request does not have a body
        request.httpBody = nil
        
        let task = URLSession.shared.dataTask(with: request) {(dataOpt, response, error) -> Void in
            guard let data = dataOpt else { return }
            print(data)
            return
        }
        task.resume()
    }
}
