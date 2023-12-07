//
//  URLSessionService.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case networkError
    case invalidResponse
    case invalidData
    case decodingError
    case unknown
}

enum NetworkMethod: String {
    case get = "GET"
}

class URLSessionService {
    private let bag = DisposeBag()
    
    func request(urlString: BaseURL,
                 urlPath: URLPath,
                 method: NetworkMethod,
                 headers: [String : String]?,
                 queryString: [String : String]?) -> Observable<Result<Data, NetworkError>> {
        
        guard let REQUEST = createURLRequest(urlString: urlString, 
                                             urlPath: urlPath,
                                             method: method,
                                             headers: headers,
                                             queryString: queryString) else { return Observable.empty()}
        
        
        return Observable<Result<Data, NetworkError>>.create { emitter in
            let task = URLSession.shared.dataTask(with: REQUEST) { data, response, error in
                if let error = error {
                    print("❌Error while get location data")
                    return emitter.onError(error)
                }
                
                guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                    return emitter.onError(NetworkError.invalidResponse)
                }
                
                guard let data = data else { return emitter.onError(NetworkError.invalidData) }
                
                emitter.onNext(.success(data))
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        
    }
    
    
    private func createURLRequest(urlString: BaseURL,
                                  urlPath: URLPath,
                                  method: NetworkMethod, 
                                  headers: [String : String]?,
                                  queryString: [String : String]?) -> URLRequest? {
        
        guard let baseURL = URL(string: urlString.rawValue) else { return nil }
        
        var fullURL = baseURL.appendingPathComponent(urlPath.rawValue)
        
        if let queryString = queryString {
            var urlComponent = URLComponents(string: fullURL.absoluteString)
            urlComponent?.queryItems = queryString.map({ qs in
                URLQueryItem(name: qs.key, value: qs.value)
            })
            
            guard let urlWithQueryString = urlComponent?.url else { return nil }
            fullURL = urlWithQueryString
        }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        headers?.forEach({ key, value in
            request.addValue(value, forHTTPHeaderField: key)
        })
        
        return request
    }
}
