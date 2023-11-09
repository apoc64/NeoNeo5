//
//  ContentView.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 1/31/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import SwiftUI
import Combine

struct NeoListView: View {
    @ObservedObject private var viewModel: NEOListViewModel = NEOListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.neos, id: \.self) { viewModel in
                NavigationLink(destination: DetailView(viewModel: viewModel)) {
                    TextCellView(viewModel: viewModel)
                }
            }.onAppear {
                self.viewModel.fetchNEOS()
            }.navigationBarTitle("NEOs")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NeoListView_Previews: PreviewProvider {
    static var previews: some View {
        NeoListView()
    }
}
