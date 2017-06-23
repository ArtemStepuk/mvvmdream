//
//  ViewController.swift
//  rx
//
//  Created by Artem Stepuk on 6/19/17.
//  Copyright © 2017 Artem Stepuk. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import CommonIOS

let presenter = { (state: ViewState) -> String in
    switch state {
    case .initial:
        return "Fill the form"

    case .invalidName:
        return "Name too short"

    case .invalidAgreement:
        return "Agree with licence."

    case .valid:
        return "Press Go"

    case .unknown:
        return "Something wrong"
    }
}

class View: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var switcher: UISwitch!
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var collectionConainer: UIView!

    var viewModel: ViewModelProtocol!

    convenience init(viewModel: ViewModelProtocol) {
        self.init(nibName:"View", bundle:Bundle.main)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.rx.text
            .bind(to: viewModel.text)
            .addDisposableTo(viewModel.disposeBag)

        switcher.rx.value
            .bind(to: viewModel.bool)
            .addDisposableTo(viewModel.disposeBag)

        viewModel.state
            .map({ $0 == .valid })
            .bind(to: button.rx.isEnabled)
            .addDisposableTo(viewModel.disposeBag)

        viewModel.state.map { presenter($0) }
            .bind(to: label.rx.text)
            .addDisposableTo(viewModel.disposeBag)
    }
}
