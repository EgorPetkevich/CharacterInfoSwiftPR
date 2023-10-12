//
//  APIResponse.swift
//  CharacterInfo
//
//  Created by George Popkich on 12.10.23.
//

import Foundation

struct CharacterInfo: Decodable {
    let info: Info
    let results: [Result]
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(Info.self, forKey: .info)
        self.results = try container.decode([Result].self, forKey: .results)
    }
}

// MARK: - Info
struct Info: Decodable {
    let count, pages: Int
    
    
    enum CodingKeys: CodingKey {
        case count
        case pages
        case prev
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.pages = try container.decode(Int.self, forKey: .pages)
        
        
    }
    
}

// MARK: - Result
struct Result: Decodable {
 
    let name, status, species: String
    let image: String
    
    enum CodingKeys: CodingKey {
        case name, status, species, type
        case gender
        case origin, location
        case image
        case episode
        case url
        case created
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.image = try container.decode(String.self, forKey: .image)
        self.species = try container.decode(String.self, forKey: .species)
    }
}



// MARK: - Location
struct Location: Decodable {
    let name: String?
    let url: String?
}
