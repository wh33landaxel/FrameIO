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
}

struct Relationships: Codable {
    
    let team: Team
    
    enum Relationships: String, CodingKey {
        case team
    }
}
