//
//  Coordinator.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 27/01/2023.
//

import Foundation
protocol CoordinatorDelegate: AnyObject {
    func didFinish()
}

class Coordinator {
    weak var delegate: CoordinatorDelegate?

    func start() {

    }

    func finish() {
        delegate?.didFinish()
    }
}
