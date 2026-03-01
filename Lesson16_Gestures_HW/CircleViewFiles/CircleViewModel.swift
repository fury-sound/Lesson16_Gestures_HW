//
//  CircleViewModel.swift
//  Lesson16_Gestures_HW
//
//  Created by Valery Zvonarev on 24.02.2026.
//

import UIKit

final class CircleViewModel {
    var location: CGPoint = .zero
    var minY: CGFloat = 0
    var maxY: CGFloat = 0
    var screenFrame: CGRect = .zero
    let circleRadius: CGFloat = 70

    func calculateY() -> CGFloat {
        switch true {
            case location.y - self.circleRadius < minY:
                return minY
            case location.y + self.circleRadius > maxY:
                return maxY - self.circleRadius * 2
            default:
                return location.y - self.circleRadius
        }
    }

    //    func calculateYMove(by value: CGFloat) -> CGFloat {
    //        switch true {
    //            case self.circleRadius + value < minY:
    //                return minY - self.circleRadius
    //            case self.circleRadius + value > maxY:
    //                return maxY - self.circleRadius * 2
    //            default:
    //                return self.circleRadius + value
    //        }
    //    }

    func calculateX() -> CGFloat {
        switch true {
            case location.x - self.circleRadius < 0:
                return 0
            case location.x + self.circleRadius > screenFrame.width:
                return screenFrame.width - self.circleRadius * 2
            default:
                return location.x - self.circleRadius
        }
    }

}
