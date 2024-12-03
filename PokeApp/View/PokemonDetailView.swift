//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by Berkin Demirel on 2.12.2024.
//

import SwiftUI
import CoreData

struct PokemonDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
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
                
                Button {
                    withAnimation {
                        pokemon.favorite.toggle()
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                } label: {
                    if pokemon.favorite {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
                .font(.largeTitle)
                .foregroundStyle(.yellow)
                
                
            }
            .padding()
            
            Text("Stats")
                .font(.title)
                .padding(.bottom, -4)
            
            StatsView()
                .environmentObject(pokemon)
        }
        .navigationTitle(pokemon.name!.capitalized)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showShiny.toggle()
                } label: {
                    if showShiny {
                        Image(systemName: "wand.and.stars")
                            .foregroundStyle(.primary)
                    } else {
                        Image(systemName: "wand.and.stars.inverse")
                            .foregroundStyle(.secondary)
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
