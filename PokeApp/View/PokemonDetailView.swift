//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by Berkin Demirel on 2.12.2024.
//

import SwiftUI
import CoreData

struct PokemonDetailView: View {
    @EnvironmentObject var pokemon: Pokemon
    @State var showShiny = false
    
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(pokemon.background)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 6)
                
                AsyncImage(url: showShiny ? pokemon.shiny : pokemon.sprite) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 50)
                        .shadow(color: .black, radius: 6)
                } placeholder: {
                    ProgressView()
                }
                
            }
            
            HStack {
                ForEach(pokemon.types!, id: \.self) { type in
                    Text(type.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                        .shadow(color: .white, radius: 2)
                        .padding([.top, .bottom], 12)
                        .padding([.leading, .trailing])
                        .background(Color(type.capitalized))
                        .cornerRadius(30)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(pokemon.name!.capitalized)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showShiny.toggle()
                } label: {
                    if showShiny {
                        Image(systemName: "wand.and.stars")
                            .foregroundStyle(.yellow, .black)
                    } else {
                        Image(systemName: "wand.and.stars.inverse")
                            .foregroundStyle(.black, .yellow)
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonDetailView()
        .environmentObject(SamplePokemon.samplePokemon)
}
