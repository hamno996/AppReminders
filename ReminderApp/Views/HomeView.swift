//
//  ContentView.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 2/25/26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResult: FetchedResults<MyList>
    @State private var isPressed: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                MyListView(myLists: myListResult)
                //Spacer()
                
                Button {
                    isPressed = true
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
//                            .foregroundColor(.black)
                        Text("New List").foregroundStyle(Color(.label))
                    }
                    .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .glassEffect()
                }.tint(.blue)
                .frame(maxWidth:.infinity , alignment: .trailing)
                .padding()
            }.sheet(isPresented: $isPressed){
                NavigationView{
                    AddNewListView{ name, color in
                        do{
                            try ReminderService.saveMyList(name,color)
                        } catch {
                            print(error)
                        }
                        
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
