//
//  HomeviewTabbarController.swift
//  Positive_Reactions
//
//  Created by Ali Hassan on 16/12/2020.
//

import UIKit

class HomeviewTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage     = UIImage()
        UITabBar.appearance().clipsToBounds   = true

        
        self.tabBar.items?[2].image = UIImage(named: "plus-square")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[2].selectedImage = UIImage(named: "plus-square")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        self.title = nil
        
    }
    

}


