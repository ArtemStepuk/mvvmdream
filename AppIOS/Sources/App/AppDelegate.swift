//
//  AppDelegate.swift
//  rx
//
//  Created by Artem Stepuk on 6/19/17.
//  Copyright © 2017 Artem Stepuk. All rights reserved.
//

import UIKit
import Swinject
import CommonIOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let diService: Container = {
        let container = Container()

        container.register(ViewModelProtocol.self, factory: { _ in
            ViewModel()
        })

        container.register(View.self, factory: { resolver in
            View(viewModel: resolver.resolve(ViewModelProtocol.self)!)
        })

        return container
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController =  diService.resolve(View.self)
        window?.makeKeyAndVisible()
        return true
    }
}
