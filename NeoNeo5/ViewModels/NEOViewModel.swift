//
//  NEOViewModel.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/5/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import Combine

class NEOListViewModel: ObservableObject {
    @Published var neos: [NEOViewModel] = []
    var cancellable: AnyCancellable?
    
    func fetchNEOS() {
        cancellable = NEOResponse.performRequest()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { neoResponse in
                    self.neos = neoResponse.neos.map(
                        { NEOViewModel(neo: $0) })
            })
    }
}

struct NEOViewModel: Hashable, TextDisplayViewModel {
    let neo: NEO
    
    var displayString: String {
        let danger = neo.isDangerous ? " DANGER" : ""
        
        return neo.name + danger
    }
}
