//
//  CollectionViewModel.swift
//  rx
//
//  Created by Artem Stepuk on 6/21/17.
//  Copyright © 2017 Artem Stepuk. All rights reserved.
//

import Foundation
import RxSwift

protocol CollectionItemProtocol {
    var name: String { get }
    var url: URL { get }
}

protocol CollectionVieModelwProtocol {
    var items: Observable<[CollectionItemProtocol]> { get }
}

struct CollectionItem: CollectionItemProtocol {
    var name: String
    var url: URL
}
