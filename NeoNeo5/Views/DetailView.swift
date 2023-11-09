//
//  DetailView.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/7/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var viewModel: TextDisplayViewModel
    
    var body: some View {
        Text(viewModel.displayString)
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(viewModel: NEOViewModel(neo: NEO(name: "Hello", designation: "lala", isDangerous: true)))
    }
}
