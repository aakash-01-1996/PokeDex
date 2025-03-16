//
//  PokemonDetail.swift
//  PokeDex
//
//  Created by Aakash Ambodkar
//

import SwiftUI

struct PokemonDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var pokemon: Pokemon
    
    @State private var showShiny = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(pokemon.background)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 6)
                
                AsyncImage(url: pokemon.sprite) { image in
                    image
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 50)
                        .shadow(color: .black, radius: 6)
                } placeholder :  {
                    ProgressView()
                }
            }
            HStack {
                ForEach(pokemon.types!, id:\.self) { type in
                    Text(type.capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .shadow(color: .white, radius: 1)
                        .padding(.vertical, 7)
                        .padding(.horizontal)
                        .background(Color(type.capitalized))
                        .clipShape(.capsule)
                }
                
                Spacer()
                
                Button {
                    pokemon.favorite.toggle()
                    
                    do {
                        try viewContext.save()
                        
                    } catch {
                        print(error)
                    }
                    
                } label: {
                    Image(systemName: pokemon.favorite ? "star.fill" : "star")
                        .font(.title)
                        .tint(.yellow)
                }
            }
            .padding()
            
            Text("Stats")
                .font(.title2)
                .padding(.bottom, -5)
                
            Stats(pokemon: pokemon)
            
        }
        .navigationTitle(pokemon.name!.capitalized)
    }
}

#Preview {
    NavigationStack{
        PokemonDetail()
            .environmentObject(PersistenceController.previewPokemon)
    }
}
