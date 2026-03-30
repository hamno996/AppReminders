//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 3/4/26.
//

import SwiftUI
import CoreData

struct ReminderListView: View {
    
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    var body: some View {
        VStack {
            List(reminders) {reminder in
                ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) {event in
                    switch event {
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    case .onCeckedChange(let reminder, let isCompleted):
                        reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                    case .onInfo:
                        showReminderDetail = true
                    }
                }
            }
        }.sheet(isPresented: $showReminderDetail){
            NavigationStack {
                ReminderDetailView(reminder: Binding($selectedReminder)!)
            }
        }
    }
}

//#Preview {
//    ReminderListView()
//}
