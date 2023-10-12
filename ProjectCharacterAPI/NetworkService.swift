//
//  NetworkService.swift
//  CharacterInfo
//
//  Created by George Popkich on 12.10.23.
//

import Foundation
import UIKit

final class NetworkService {
    
    func loadInfo(complition: @escaping (CharacterInfo?) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            // Convert data to models/some object
            let responseObject = try! JSONDecoder().decode(CharacterInfo.self, from: data)
            DispatchQueue.main.async {
                complition(responseObject)
            }
            
            
            
        }.resume()
    }
        
        func loadImage(url: URL, compliton: @escaping (UIImage) -> Void) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                            error == nil,
                            let image = UIImage(data: data)
                    else {print("something went wrong")
                    return
                }
                DispatchQueue.main.async() {
                    compliton(image)
                }
            }.resume()
        }
        
    
        
}
