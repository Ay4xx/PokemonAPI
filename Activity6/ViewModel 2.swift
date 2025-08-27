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

    var errorMessage: String? = nil
    var isLoading: Bool = false

    init() {
        Task {
            do {
                try await fetchList()
                for entry in arrPokeList {
                    try await fetchDetail(from: entry.url)
                }
            } catch {
                // Si algo falla en la carga inicial, reflejarlo en la UI
                self.errorMessage = self.mapError(error)
            }
        }
    }

    // GET request to https://pokeapi.co/api/v2/pokemon?limit=20&offset=0
    // primeros 20
    // (PokeAPI endpoint for listing Pokémon)
    func fetchList() async throws {
        // preparar estado
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0") else {
            // reportar error
            errorMessage = "URL inválida para la lista."
            throw URLError(.badURL)
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let http = response as? HTTPURLResponse else {
                errorMessage = "Respuesta inválida del servidor."
                throw URLError(.badServerResponse)
            }
            guard http.statusCode == 200 else {
                errorMessage = "La API devolvió un error (\(http.statusCode))."
                throw URLError(.badServerResponse)
            }

            let results = try JSONDecoder().decode(PokemonListResponse.self, from: data)
            self.arrPokeList = results.results

        } catch {
            // mapear y propagar
            errorMessage = mapError(error)
            throw error
        }
    }

    // GET request to https://pokeapi.co/api/v2/pokemon/{id}/
    // (PokeAPI endpoint for Pokémon details)
    func fetchDetail(from url: String) async throws {
        // preparar estado
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        guard let url = URL(string: url) else {
            errorMessage = "URL inválida para detalle."
            throw URLError(.badURL)
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let http = response as? HTTPURLResponse else {
                errorMessage = "Respuesta inválida del servidor."
                throw URLError(.badServerResponse)
            }
            guard http.statusCode == 200 else {
                errorMessage = "La API devolvió un error (\(http.statusCode))."
                throw URLError(.badServerResponse)
            }

            let result = try JSONDecoder().decode(Pokemon.self, from: data)
            self.arrPokeDetail.append(result)
            self.arrPokeDetail.sort { $0.id < $1.id }

        } catch {
            //
            errorMessage = mapError(error)
            throw error
        }
    }

    // helper para traducir errores a mensajes amigables
    private func mapError(_ error: Error) -> String {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "No connection. Please try again."
            case .timedOut:
                return "La solicitud tardó demasiado. Intenta de nuevo."
            default:
                return "Error de red: \(urlError.localizedDescription)"
            }
        }
        return "Ocurrió un error: \(error.localizedDescription)"
    }
}
