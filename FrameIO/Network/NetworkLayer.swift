//
//  NetworkLayer.swift
//  FrameIO
//
//  Created by Axel Nunez on 11/7/19.
//  Copyright © 2019 Axel Nunez. All rights reserved.
//

import Foundation

class NetworkLayer {
    
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
    
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) {
            data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            guard response != nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
    
        dataTask.resume()
    }
}
