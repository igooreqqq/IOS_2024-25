//
//  Task.swift
//  todo_app
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
    var imageName: String
}
