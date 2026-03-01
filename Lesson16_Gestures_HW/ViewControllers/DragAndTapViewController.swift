//
//  DragAndTapViewController.swift
//  Lesson16_Gestures_HW
//
//  Created by Valery Zvonarev on 01.03.2026.
//

import UIKit

final class DragAndTapViewController: UIViewController {

    // MARK: - Properties
    private let constantY: CGFloat = 0
    private let constantX: CGFloat = 0
    private var circleRadius: CGFloat = 0
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?

    // MARK: - Subviews
    private lazy var circleView: CircleView = {
        let view = CircleView(frame: .zero, screenType: .drag)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        view.layer.masksToBounds = true
        view.alpha = 0
        return view
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Layout
    private func setupViewProperties(){
        view.backgroundColor = .tertiarySystemBackground
    }

    private func setupSubviews(){
        let safeAreaInsets = view.safeAreaInsets
        circleView.circleMV.minY = safeAreaInsets.top
        circleView.circleMV.maxY = view.frame.height - safeAreaInsets.bottom
        circleView.circleMV.screenFrame = view.frame
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
        let safeAreaInsets = view.safeAreaInsets
        circleView.circleMV.minY = safeAreaInsets.top
        circleView.circleMV.maxY = view.frame.height - safeAreaInsets.bottom
        guard let touch = touches.first else { return }
        circleView.circleMV.location = touch.location(in: view)
        if circleView.alpha == 0 {
            self.topConstraint?.constant = circleView.circleMV.calculateY()
            self.leadingConstraint?.constant = circleView.circleMV.calculateX()

            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.circleView.alpha = 1
            }
        }
    }
}

#Preview {
    DragAndTapViewController()
}

