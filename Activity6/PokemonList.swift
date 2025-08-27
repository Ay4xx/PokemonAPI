//
//  PokemonList.swift
//  Activity6
//
//  Created by Alumno on 26/08/25.
//

import Foundation


struct PokemonListResponse : Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonEntry]
}

// Cada entrada (name + url)
struct PokemonEntry: Codable, Identifiable, Hashable {
    var id: Int {
        // Extraer el ID de la URL (ej: ".../pokemon/1/")
        if let last = url.split(separator: "/").dropLast().last {
            return Int(last) ?? -1
        }
        return -1
    }
    
    let name: String
    let url: String
}
