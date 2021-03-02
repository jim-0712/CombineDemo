//
//  ViewController.swift
//  CombineDemo
//
//  Created by Fu Jim on 2021/2/26.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let SimpleDemoVC = SimpleDemoViewController()
        let SimpleVC = UINavigationController(rootViewController: SimpleDemoVC)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        SimpleVC.navigationBar.titleTextAttributes = textAttributes
        SimpleVC.navigationBar.topItem?.title = "Simple"
        SimpleVC.tabBarItem.title = "Simple"
        
        let APIDemoVC = APIDemoViewController()
        let APINaviVC = UINavigationController(rootViewController: APIDemoVC)
        APINaviVC.navigationBar.titleTextAttributes = textAttributes
        APINaviVC.navigationBar.topItem?.title = "APIDemp"
        APINaviVC.tabBarItem.title = "APIDemp"
        
        viewControllers = [SimpleVC, APINaviVC]
    }
}

