//
//  ViewModel.swift
//  Activity6
//
//  Created by Alumno on 26/08/25.
//

import Observation
import Foundation


@MainActor
@Observable
class PokemonListViewModel {
    var arrPokeList = [PokemonEntry]()
    var arrPokeDetail = [Pokemon]()
    
    init() {
        
        Task{
            try await fetchList()
            for entry in arrPokeList {
                    try await fetchDetail(from: entry.url)
                }
        }
    }
    
    func fetchList() async throws {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0") else {
            print("Invalid URL")
            return
        }
        
        let urlRequest = URLRequest(url : url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("error")
            return
        }
        
        let results = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        
        self.arrPokeList = results.results
        
    }
    
    func fetchDetail(from url : String) async throws{
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let urlRequest = URLRequest(url : url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("error")
            return
        }
        
        let result = try JSONDecoder().decode(Pokemon.self, from: data)

        self.arrPokeDetail.append(result)

    }

}

