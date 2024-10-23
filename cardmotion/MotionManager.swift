//
//  MotionManager.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//

import Foundation
import CoreMotion
import SwiftUI

class MotionManager: ObservableObject {
    private var motion = CMMotionManager()
    @Published var pitch: CGFloat = 0
    @Published var roll: CGFloat = 0

    init() {
        motion.deviceMotionUpdateInterval = 1 / 60
        motion.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let data = data else { return }
            self?.pitch = CGFloat(data.attitude.pitch)
            self?.roll = CGFloat(data.attitude.roll)
        }
    }
}
