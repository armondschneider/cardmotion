//
//  MotionManager.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//

import CoreMotion
import SwiftUI

class MotionManager: ObservableObject {
    private var motion = CMMotionManager()
    @Published var pitch: CGFloat = 0
    @Published var roll: CGFloat = 0

    private let filterFactor: Double = 0.1 // Gives it that smoother animation

    init() {
        motion.deviceMotionUpdateInterval = 1 / 60
        motion.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let data = data else { return }

            self?.pitch = CGFloat((1 - self!.filterFactor) * Double(self!.pitch) +
                                  self!.filterFactor * data.attitude.pitch)
            
            self?.roll = CGFloat((1 - self!.filterFactor) * Double(self!.roll) +
                                 self!.filterFactor * data.attitude.roll)
        }
    }
}
