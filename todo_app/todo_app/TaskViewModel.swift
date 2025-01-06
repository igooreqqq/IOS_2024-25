//
//  TaskViewModel.swift
//  todo_app
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(title: "Zrobić zakupy", isCompleted: false, imageName: "cart"),
        Task(title: "Napisać raport", isCompleted: false, imageName: "doc.text"),
        Task(title: "Posprzątać pokój", isCompleted: true, imageName: "house")
    ]
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
