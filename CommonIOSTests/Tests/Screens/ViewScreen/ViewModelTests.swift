//
//  ViewModelTests.swift
//  rx
//
//  Created by Artem Stepuk on 6/23/17.
//  Copyright © 2017 Artem Stepuk. All rights reserved.
//

import XCTest

@testable import CommonIOS

class ViewModelTests: XCTestCase {
    func testInitialState() {

        let model = ViewModel()

        model.text.value = ""
        model.bool.value = false

        let disposable = model.state
            .asObservable()
            .subscribe(onNext: { state in
                XCTAssert(state == .initial)
            })

        disposable.dispose()
    }

    func testValidState() {
        let model = ViewModel()

        model.text.value = "artem"
        model.bool.value = true

        let disposable = model.state
            .asObservable()
            .subscribe(onNext: { state in
                XCTAssert(state == .valid)
            })

        disposable.dispose()
    }

    func testInvalidNameState() {
        let model = ViewModel()

        model.text.value = "ar"
        model.bool.value = true

        let disposable = model.state
            .asObservable()
            .subscribe(onNext: { state in
                XCTAssert(state == .invalidName)
            })

        disposable.dispose()
    }

    func testInvalidAgreementState() {
        let model = ViewModel()

        model.text.value = "artem"
        model.bool.value = false

        let disposable = model.state
            .asObservable()
            .subscribe(onNext: { state in
                XCTAssert(state == .invalidAgreement)
            })

        disposable.dispose()
    }
}
