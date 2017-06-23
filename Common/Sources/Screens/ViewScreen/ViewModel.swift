//
//  ViewModel.swift
//  rx
//
//  Created by Artem Stepuk on 6/19/17.
//  Copyright © 2017 Artem Stepuk. All rights reserved.
//

import Foundation
import RxSwift

//MARK : Inerface -

public enum ViewState {
    case unknown
    case initial
    case invalidName
    case invalidAgreement
    case valid
}

public protocol ViewModelProtocol {

    var disposeBag: DisposeBag { get }

    var text: Variable<String?> { get }
    var bool: Variable<Bool> { get }

    var state: Observable<ViewState> { get }
}

//MARK : - Presentation Validation

public typealias ModelValidator = (String) -> Bool

internal let defaultValidator = { (str: String) -> Bool in
    return str.characters.count > 3
}

//MARK : - ViewModel

public class ViewModel: ViewModelProtocol {

    public var disposeBag = DisposeBag()

    public var text = Variable<String?>(nil)
    public var bool = Variable(false)

    public private(set) var state: Observable<ViewState>

    public init(defaultName: String = "", validator: @escaping ModelValidator = defaultValidator) {

        let transformator = { (text: String?) -> String in
            if let text = text {
                if text.characters.count == 0 {
                    return defaultName
                } else {
                    return text
                }
            } else {
                return defaultName
            }
        }

        let nameValidator = { (name: String) -> Bool in
            if name == defaultName {
                return false
            } else {
                return validator(name)
            }
        }

        let stateValidator = { (str: String, bool: Bool) -> ViewState in

            switch (str, bool) {

            case (defaultName, false):
                return .initial

            case (str, true):

                if nameValidator(str) {
                    return .valid
                } else {
                    return .invalidName
                }

            case (_, false):
                return .invalidAgreement

            default:
                return .unknown
            }
        }

        self.state = Observable.combineLatest(self.text.asObservable().map(transformator),
                                              self.bool.asObservable(),
                                              resultSelector: stateValidator)
    }
}
