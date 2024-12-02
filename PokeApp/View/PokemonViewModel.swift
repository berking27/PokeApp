//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by Berkin Demirel on 1.12.2024.
//

import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    enum Status<T> {
        case notStarted
        case fetching
        case success(data: T)
        case failed(error: Error)
    }
    
    @Published private(set) var status = Status<[TempPokemon]>.notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
        
        Task {
            await getPokemon()
        }
    }
    
    private func getPokemon() async {
        status = .fetching
        
        do {
            var pokeDex = try await controller.fetchAllPokemon()
            
            pokeDex.sort { $0.id < $1.id }
            
            for pokemon in pokeDex {
                try savePokemon(pokemon)
            }
            
            status = .success(data: pokeDex)
        } catch {
            status = .failed(error: error)
        }
    }
    
    
    private func savePokemon(_ pokemon: TempPokemon) throws {
        let context = PersistenceController.shared.container.viewContext
        let newPokemon = Pokemon(context: context)
        
        newPokemon.id = Int16(pokemon.id)
        newPokemon.name = pokemon.name
        newPokemon.types = pokemon.types
        newPokemon.hp = Int16(pokemon.hp)
        newPokemon.attack = Int16(pokemon.attack)
        newPokemon.defense = Int16(pokemon.defense)
        newPokemon.specialAttack = Int16(pokemon.specialAttack)
        newPokemon.specialDefense = Int16(pokemon.specialDefense)
        newPokemon.speed = Int16(pokemon.speed)
        newPokemon.sprite = pokemon.sprite
        newPokemon.shiny = pokemon.shiny
        newPokemon.favorite = false
        
        try context.save()
    }
    
    
    private func handleError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
        status = .failed(error: error)
    }
}