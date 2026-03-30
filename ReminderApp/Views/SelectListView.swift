//
//  SelectListView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 3/30/26.
//

import SwiftUI
import CoreData

struct SelectListView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchRequest: FetchedResults<MyList>
    @Binding var selectList: MyList
    
    var body: some View {
        List(myListsFetchRequest) {myList in
            HStack {
                HStack{
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(myList.color))
                    Text(myList.name!)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectList = myList
                }
                
                if selectList == myList{
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    SelectListView(selectList: .constant(PreviewData.myLists))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
