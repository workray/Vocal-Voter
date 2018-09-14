//
//  Application.swift
//  MVVMRxSwift
//
//  Created by Mobdev125 on 2/13/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform
import RealmPlatform

final class Application {
    static let shared = Application()
    
    private let realmUseCaseProvider: Domain.UseCaseProvider
    private let networkUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.realmUseCaseProvider = RealmPlatform.UseCaseProvider()
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let rmNavigationController = UINavigationController()
        rmNavigationController.tabBarItem = UITabBarItem(title: "Realm",
                                                         image: UIImage(named: "Toolbox"),
                                                         selectedImage: nil)
        let rmNavigator = DefaultPostsNavigator(services: realmUseCaseProvider,
                                                navigationController: rmNavigationController,
                                                storyBoard: storyboard)
        
        let networkNavigationController = UINavigationController()
        networkNavigationController.tabBarItem = UITabBarItem(title: "Network",
                                                              image: UIImage(named: "Toolbox"),
                                                              selectedImage: nil)
        let networkNavigator = DefaultPostsNavigator(services: networkUseCaseProvider,
                                                     navigationController: networkNavigationController,
                                                     storyBoard: storyboard)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            rmNavigationController,
            networkNavigationController
        ]
        window.rootViewController = tabBarController
        
        rmNavigator.toPosts()
        networkNavigator.toPosts()
    }
}

