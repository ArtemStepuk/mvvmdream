//
//  ViewController.swift
//  rxmac
//
//  Created by Artem Stepuk on 6/21/17.
//  Copyright © 2017 Artem Stepuk. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa
import CommonMac

let presenter = { (state: ViewState) -> NSImage in
    switch state {
    case .initial:
        return #imageLiteral(resourceName: "initial")

    case .invalidName:
        return #imageLiteral(resourceName: "invalidName")

    case .invalidAgreement:
        return #imageLiteral(resourceName: "invalideAgreement")

    case .valid:
        return #imageLiteral(resourceName: "valid")

    case .unknown:
        return #imageLiteral(resourceName: "initial")
    }
}

class View: NSViewController {

    var viewModel: ViewModelProtocol!

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var text: NSTextField!
    @IBOutlet weak var switcher: NSButton!
    @IBOutlet weak var button: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ViewModel()

        text.rx.text
            .bind(to: viewModel.text)
            .addDisposableTo(viewModel.disposeBag)

        switcher.rx.state
            .map({ $0 != 0 })
            .bind(to: viewModel.bool)
            .addDisposableTo(viewModel.disposeBag)

        viewModel.state
            .map({ $0 == .valid })
            .bind(to: button.rx.isEnabled)
            .addDisposableTo(viewModel.disposeBag)

        viewModel.state.map { presenter($0)}
            .bind(to: imageView.rx.image)
            .addDisposableTo(viewModel.disposeBag)
    }
}
