//
//  TextListCell.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/7/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import SwiftUI

struct TextCellView: View {
    var viewModel: TextDisplayViewModel
    
    var body: some View {
        HStack {
            Image(systemName: imageNames.shuffled().first ?? "wake")
                .font(.largeTitle)
                .foregroundColor(colors.shuffled().first)
            Text(viewModel.displayString)
                .font(.subheadline)
                .bold()
                .kerning(1.2)
        }
    }
    
    let imageNames = ["sparkles", "leaf", "wand.and.stars"]
    let colors = [Color.green, Color.blue, Color.purple, Color.orange, Color.pink]
}

struct TextCellView_Preview: PreviewProvider {
    static var previews: some View {
        let viewModel = NEOViewModel(neo: NEO(name: "Lalala", designation: "434t5545", isDangerous: true))
        TextCellView(viewModel: viewModel)
    }
}
