//
//  ContentView.swift
//  todo_app
//
//  Created by user252224 on 12/14/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    TaskRowView(task: task, toggleCompletion: {
                        viewModel.toggleTaskCompletion(task)
                    })
                }
                .onDelete(perform: viewModel.deleteTask)
            }
            .navigationTitle("Moje Zadania")
        }
    }
}
