//
//  TaskItemCell.swift
//  AdapSchApp
//
//  Created by Sonny Cooper on 08/09/2023.
//

import SwiftUI

struct TaskItemCell: View {
    let background: [String]
    let task: Task
    
    //when true add screen is shown
    @State private var isPresented: Bool = false
    @Environment(\.colorScheme) var darkMode
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        HStack{
            VStack{
                Text(task.title)
                Text("due \(dateFormatter.string(from: task.dueDate))")
            }
            Spacer()
            ProgressView(value: Float(task.timeDone), total: Float(task.time)) //error maker
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(darkMode == .light ? Color(UIColor(hex: background[0]) ?? .red) : Color(UIColor(hex: background[1]) ?? .red)))
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding()
        
        .onTapGesture {
            isPresented = true
        }
        
        //when true addTaskView slides up -- will crash if done a second time dues to bool already being true
        .sheet(isPresented: $isPresented, content: {
            TimerView()
        })
    }
}

struct TaskItemCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemCell(background: ["#1123ff", "#23ffff"], task: Task())
    }
}
