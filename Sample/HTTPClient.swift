//
//  HTTPClient.swift
//  Sample
//
//  Created by Adattiri, Ramya (Cognizant) on 31/12/18.
//  Copyright © 2018 Adattiri, Ramya (Cognizant). All rights reserved.
//

import Foundation

typealias FailureBlock = (_ error: NSError) -> Void
typealias SuccessBlock<T: Decodable> = (_ response: T) -> Void

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

class HTTPClient {
    
    private let session: URLSessionProtocol
    
    static let shared = HTTPClient(session: URLSession.shared)
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    private func execute<T: Decodable>(_ url: URL?, method: String = "GET", parameters: [String: Any]? = nil, success: @escaping SuccessBlock<T>, failure: @escaping FailureBlock) {
        guard let url = url else { return }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = method
        //TODO: - Get the format for passing parameters for POST request
        let session = self.session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                self.handleError(error! as NSError, failure: failure)
                return
            }
            self.handle(response: response!, with: data!, success: success, failure: failure) //TODO: - Make this safe
        }
        session.resume()
    }
    
    private func handle<T: Decodable>(response: URLResponse, with data: Data, success: SuccessBlock<T>, failure: FailureBlock) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        let code = httpResponse.statusCode
        if code == 200 {
            self.handleResponseData(data, success: success, failure: failure)
        } else if code == 401 || code == 403 {
            let error = NSError(domain: "Response error domain", code: -102,
                                userInfo: [NSLocalizedDescriptionKey: "Session out"])
            failure(error)
        } else {
            let error = NSError(domain: "Response error domain", code: -102,
                                userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])

            failure(error)
        }
    }

    func handleResponseData<T: Decodable>(_ data: Data, success: SuccessBlock<T>, failure: FailureBlock) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter().APIDateFormat)
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            success(response)
        } catch let error {
            failure(error as NSError)
        }
    }
    
    func get<T: Decodable>(with url: URL, success: @escaping SuccessBlock<T>, failure: @escaping FailureBlock) {
        execute(url, method: "GET", success: success, failure: failure)
    }
    
    func post<T: Decodable>(with url: URL, parameters: [String: Any], success: @escaping SuccessBlock<T>, failure: @escaping FailureBlock) {
        execute(url, method: "POST", parameters: parameters, success: success, failure: failure)
    }
    
    func handleError(_ error: NSError, failure: FailureBlock) {
        failure(error)
    }
    
    func get<T: Decodable>(_ url: URL?, success: @escaping (_ response: T) -> Void, failure: @escaping FailureBlock) {
        if let url = url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            let session = self.session.dataTask(with: urlRequest) { (data, response, error) in
                if let err = error {
                    failure(err as NSError)
                } else if let responseData = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter().APIDateFormat)
                        let response = try jsonDecoder.decode(T.self, from: responseData)
                        success(response)
                    } catch let error {
                        failure(error as NSError)
                    }
                }
            }
            session.resume()
        }
    }
    

}
