//
//  TaskRowView.swift
//  todo_app
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task
    let toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: task.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding()
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text(task.isCompleted ? "Ukończone" : "Do zrobienia")
                    .font(.subheadline)
                    .foregroundColor(task.isCompleted ? .green : .red)
            }
            
            Spacer()
            
            Button(action: toggleCompletion) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .font(.title)
            }
        }
    }
}
