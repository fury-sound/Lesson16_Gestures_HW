//
//  MainTabBarViewController.swift
//  Lesson16_Gestures_HW
//
//  Created by Valery Zvonarev on 01.03.2026.
//

import UIKit

enum ScreenType {
    case swipe
    case drag
}

final class MainTabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    // MARK: - Layout
    private func setupTabs() {
        let swipeVC = SwipeAndTapViewController()
//        let swipeNav = UINavigationController(rootViewController: swipeVC)
        swipeVC.tabBarItem = UITabBarItem(title: "Swipe", image: UIImage(systemName: "arrowshape.left.arrowshape.right"), tag: 0)

        let dragVC = DragAndTapViewController()
//        let dragNav = UINavigationController(rootViewController: dragVC)
        dragVC.tabBarItem = UITabBarItem(title: "Drag", image: UIImage(systemName: "hand.draw"), tag: 1)

        viewControllers = [swipeVC, dragVC]
        view.backgroundColor = .systemBackground
    }
}

#Preview {
    MainTabBarViewController()
}

