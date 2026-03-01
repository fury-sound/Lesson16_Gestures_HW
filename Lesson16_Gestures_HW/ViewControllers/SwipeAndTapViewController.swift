//
//  SwipeAndTapViewController.swift
//  Lesson16_Gestures_HW
//
//  Created by Valery Zvonarev on 23.02.2026.
//

import UIKit

final class SwipeAndTapViewController: UIViewController {

    // MARK: - Properties
//    private let safeAreaInsets = view.safeAreaInsets
    private let constantY: CGFloat = 0
    private let constantX: CGFloat = 0
    private var circleRadius: CGFloat = 0
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?

    // MARK: - Subviews
    private lazy var circleView: CircleView = {
        let view = CircleView(frame: .zero, screenType: .swipe)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.layer.masksToBounds = true
        view.alpha = 0
        return view
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Layout
    private func setupViewProperties(){
        view.backgroundColor = .secondarySystemBackground
    }

    private func setupSubviews(){
        let safeAreaInsets = view.safeAreaInsets
//        print("circleView.screenTypeVar", circleView.screenTypeVar)
        circleView.circleMV.minY = safeAreaInsets.top
        circleView.circleMV.maxY = view.frame.height - safeAreaInsets.bottom
        circleView.circleMV.screenFrame = view.frame
//        circleView.circleMV.screenType = .swipe
        circleRadius = circleView.circleMV.circleRadius
        view.addSubview(circleView)
    }

    private func setupConstraints(){
        topConstraint = circleView.topAnchor.constraint(equalTo: view.topAnchor, constant: constantY)
        leadingConstraint = circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantX)
        guard let topConstraint, let leadingConstraint else { return }
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            circleView.widthAnchor.constraint(equalToConstant: circleRadius * 2),
            circleView.heightAnchor.constraint(equalToConstant: circleRadius * 2)
        ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event!)
//        print("VC tag:", self.tabBarItem.tag)
//        print(circleView.circleMV.screenType)
//        print("touchesBegin")
        let safeAreaInsets = view.safeAreaInsets
//        let minY = safeAreaInsets.top
//        let maxY = view.frame.height - safeAreaInsets.bottom

        circleView.circleMV.minY = safeAreaInsets.top
        circleView.circleMV.maxY = view.frame.height - safeAreaInsets.bottom
        guard let touch = touches.first else { return }
        circleView.circleMV.location = touch.location(in: view)
//        let location = touch.location(in: view)
        if circleView.alpha == 0 {
            self.topConstraint?.constant = circleView.circleMV.calculateY()
            self.leadingConstraint?.constant = circleView.circleMV.calculateX()

            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.circleView.alpha = 1
//                                self.view.layoutIfNeeded()
            }
        }
        //        else {
        //            self.circleView.isHidden = true
        //            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
        //                self.view.layoutIfNeeded()
        //            }
        //        }
    }

    //    @objc private func didTapButton(){
    //    }
}

#Preview {
    SwipeAndTapViewController()
}



//            print("touchesBegan in \(location)")
//            if location.y - self.circleRadius < 0 {
//                self.topConstraint?.constant = self.circleRadius
//            } else {
//                self.topConstraint?.constant = location.y - self.circleRadius
//            }
//            print("view.frame.height:", view.frame.height)
//            print(location.y)
//            self.topConstraint?.constant = (location.y - self.circleRadius < 0) ? 0 : location.y - self.circleRadius
//            self.topConstraint?.constant = (location.y - self.circleRadius > view.frame.height) ? location.y : location.y - self.circleRadius
//            print(location.y - self.circleRadius)
//            if location.y - self.circleRadius < 0 {
//                self.topConstraint?.constant = 0
//            } else if location.y + self.circleRadius > view.frame.height {
//                self.topConstraint?.constant = view.frame.height - self.circleRadius * 2
//            } else {
//                self.topConstraint?.constant = location.y - self.circleRadius
//            }
//            print(self.topConstraint?.constant)

//            switch true {
//                case location.y - self.circleRadius < 0:
//                    self.topConstraint?.constant = 0
//                case location.y + self.circleRadius > view.frame.height:
//                    self.topConstraint?.constant = view.frame.height - self.circleRadius * 2
//                default:
//                    self.topConstraint?.constant = location.y - self.circleRadius
//            }

//            switch true {
//                case location.y - self.circleRadius < minY:
//                    self.topConstraint?.constant = minY
//                case location.y + self.circleRadius > maxY:
//                    self.topConstraint?.constant = maxY - self.circleRadius * 2
//                default:
//                    self.topConstraint?.constant = location.y - self.circleRadius
//            }



//            switch true {
//                case location.x - self.circleRadius < 0:
//                    self.leadingConstraint?.constant = 0
//                case location.x + self.circleRadius > view.frame.width:
//                    self.leadingConstraint?.constant = view.frame.width - self.circleRadius * 2
//                default:
//                    self.leadingConstraint?.constant = location.x - self.circleRadius
//            }


//            self.leadingConstraint?.constant = location.x - self.circleRadius
//            self.circleView.isHidden = false
