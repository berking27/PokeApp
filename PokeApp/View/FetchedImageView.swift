//
//  FetchedImageView.swift
//  PokeApp
//
//  Created by Berkin Demirel on 3.12.2024.
//

import SwiftUI

struct FetchedImageView: View {
    let url: URL?
    
    var body: some View {
        if let url,
           let imageData = try? Data(contentsOf: url),
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        } else {
            Image(.bulbasaur)
        }
    }
}

#Preview {
    FetchedImageView(url: SamplePokemon.samplePokemon.sprite)
}
