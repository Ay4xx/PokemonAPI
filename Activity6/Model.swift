//
//  Model.swift
//  Activity6
//
//  Created by Alumno on 26/08/25.
//

import Foundation


struct Pokemon : Identifiable, Codable {
    var id: Int
    var name: String
    var height: Double   // metros
    var base_experience: Int
    var species: Species
    var sprites: Sprites
    
    struct Species: Codable, Equatable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable, Equatable {
        let front_default: String?
    }


    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case height
        case base_experience
        case species
        case sprites
    }
}
