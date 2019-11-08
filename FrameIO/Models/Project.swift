//
//  Project.swift
//  FrameIO
//
//  Created by Axel Nunez on 11/7/19.
//  Copyright © 2019 Axel Nunez. All rights reserved.
//

import Foundation

struct Project: Codable {
    
    let relationships: Relationships
    let type: String
    let id: Int
    let projectAttributes : ProjectAttributes
    
    enum Project: String, CodingKey {
        case relationships
        case type
        case id
        case projectAttributes = "attributes"
    }
}

struct Relationships: Codable {
    
    let team: Team
    
    enum Relationships: String, CodingKey {
        case team
    }
}

struct ProjectAttributes: Codable {
    
    let updatedAt: String
    let name: String
    
    enum ProjectAttributes: String, CodingKey {
        
        case updatedAt = "updated_at"
        case name
    }
}
