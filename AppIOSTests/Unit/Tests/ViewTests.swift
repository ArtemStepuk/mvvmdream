//
//  rxTests.swift
//  rxTests
//
//  Created by Artem Stepuk on 6/19/17.
//  Copyright © 2017 Artem Stepuk. All rights reserved.
//

import XCTest
import CommonIOS
import FBSnapshotTestCase
import RxSwift
import RxCocoa

class ViewSnapshotTests: FBSnapshotTestCase {

    class ViewModelMock: ViewModelProtocol {

        var disposeBag: DisposeBag = DisposeBag()

        var text: Variable<String?> = Variable("")
        var bool: Variable<Bool> = Variable(false)

        var stateVariable: Variable<ViewState> = Variable(.initial)

        var state: Observable<ViewState> {
            return stateVariable.asObservable()
        }
    }

    override func setUp() {
        super.setUp()
//        recordMode = true
    }

    func testInitialState() {

        let viewModel = ViewModelMock()
        let view = View(viewModel: viewModel)

        viewModel.stateVariable.value = .initial

        FBSnapshotVerifyView(view.view)
    }

    func testValidState() {

        let viewModel = ViewModelMock()
        let view = View(viewModel: viewModel)

        viewModel.stateVariable.value = .valid

        FBSnapshotVerifyView(view.view)
    }

    func testInvalideNameState() {

        let viewModel = ViewModelMock()
        let view = View(viewModel: viewModel)

        viewModel.stateVariable.value = .invalidName

        FBSnapshotVerifyView(view.view)
    }

    func testInvalideAgreementState() {

        let viewModel = ViewModelMock()
        let view = View(viewModel: viewModel)

        viewModel.stateVariable.value = .invalidAgreement

        FBSnapshotVerifyView(view.view)
    }
}
