//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 3/4/26.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    var body: some View {
        List(reminders) {reminder in
            ReminderCellView(reminder: reminder)
        }
    }
}

//#Preview {
//    ReminderListView()
//}
