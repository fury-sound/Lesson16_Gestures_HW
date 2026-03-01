//
//  CircleView.swift
//  Lesson16_Gestures_HW
//
//  Created by Valery Zvonarev on 23.02.2026.
//

import UIKit

final class CircleView: UIView {

    // MARK: - Properties
    let circleMV = CircleViewModel()
    var screenTypeVar: ScreenType

    // MARK: - Lifecycles
    init(frame: CGRect, screenType: ScreenType) {
        self.screenTypeVar = screenType
        super.init(frame: frame)
        setupViewProperties()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    private func setupViewProperties(){
        backgroundColor = .systemRed
        layer.cornerRadius = circleMV.circleRadius
    }

    private func setupGestures() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(didSingleTap))
        addGestureRecognizer(singleTap)

        if screenTypeVar == .swipe {
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
            swipeUp.direction = .up
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
            swipeDown.direction = .down
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
            swipeLeft.direction = .left
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
            swipeRight.direction = .right
            [swipeUp, swipeDown, swipeLeft, swipeRight].forEach { addGestureRecognizer($0) }
        } else {
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
            addGestureRecognizer(panGesture)
        }
    }


    @objc private func didPan(_ gesture: UIPanGestureRecognizer) {
        guard let superview = self.superview else { return }
        let superBounds = superview.bounds
        let safeTop = superview.safeAreaInsets.top
        let safeBottom = superview.safeAreaInsets.bottom
        let radius = circleMV.circleRadius
        let goodMinX = superBounds.minX + radius
        let goodMaxX = superBounds.maxX - radius
        let goodMinY = superBounds.minY + safeTop + radius
        let goodMaxY = superBounds.maxY - safeBottom - radius

        let translation = gesture.translation(in: superview)

        var newX = center.x + translation.x
        var newY = center.y + translation.y
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            newX = min(goodMaxX, max(goodMinX, newX))
            newY = min(goodMaxY, max(goodMinY, newY))
            self.center = CGPoint(x: newX, y: newY)
        }
        gesture.setTranslation(.zero, in: superview)
        switch gesture.state {
            case .began:
                self.alpha = 0.7
            case .ended, .cancelled:
                self.alpha = 1
            default: break
        }
    }

    @objc private func didSingleTap(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.alpha = 0
        }
    }

    @objc private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let superview = self.superview else { return }
        let superBounds = superview.bounds
        let safeTop = superview.safeAreaInsets.top
        let safeBottom = superview.safeAreaInsets.bottom
        let radius = circleMV.circleRadius
        let moveStep: CGFloat = 100

        switch gesture.direction {
            case .up:
                let newY = max(center.y - moveStep, radius)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    if newY + radius <= (superBounds.maxY - safeBottom) && newY - radius >= (superBounds.minY + safeTop) {
                        self.center.y = newY
                    } else {
                        self.center.y = radius + safeTop
                    }
                }
            case .down:
                let newY = min(center.y + moveStep, superBounds.maxY - safeBottom - radius)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    if newY + radius <= (superBounds.maxY - safeBottom) && newY - radius >= (superBounds.minY + safeTop) {
                        self.center.y = newY
                    } else {
                        self.center.y = superBounds.maxY - safeBottom - radius
                    }
                }
            case .left:
                let newX = max(center.x - moveStep, radius)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    if newX + radius <= superBounds.maxX && newX - radius >= superBounds.minX {
                        self.center.x = newX
                    } else {
                        self.center.x = radius
                    }
                }
            case .right:
                let newX = min(center.x + moveStep, superBounds.maxX - radius)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    if newX + radius <= superBounds.maxX && newX - radius >= superBounds.minX {
                        self.center.x = newX
                    } else {
                        self.center.x = superBounds.maxX - radius
                    }
                }
            default:
                break
        }
    }
}


