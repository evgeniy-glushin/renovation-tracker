
import SwiftUI
import Combine

struct EditView: View {
    @State var renovationProject: RenovationProject
    @Binding var showingEditView: Bool
    var editPublisher: PassthroughSubject<RenovationProject, Never>
     
    
    var body: some View {
        VStack {
            Form {
                Section("Project Info", content: {
                    TextField("Renovation area", text: $renovationProject.renovationArea)
                    
                    DatePicker(
                        selection: $renovationProject.dueDate,
                        displayedComponents: .date,
                        label: { Text("Pick date") })
                    
                    Picker(selection: $renovationProject.workQuality, label: Text("Work Quality Rating"), content: {
                        ForEach(
                            RenovationProject.WorkQualityRating.allCases.reversed(),
                            id: \.rawValue,
                            content: { Text($0.rawValue).tag($0) })
                    })
                    
                    Toggle("Flagged for review", isOn: $renovationProject.isFlagged)
                })
                
                Section("Punch list", content: {
                    ForEach(renovationProject.punchList, id: \.task, content: { punchListItem in
                        let punchListItemIndex = renovationProject.punchList.firstIndex(where: {$0.task == punchListItem.task })!
                        
                        let punchListItemBinding = $renovationProject.punchList[punchListItemIndex]
                        
                        Picker(punchListItem.task, selection: punchListItemBinding.status) {
                            Text("Not Started").tag(PunchListItem.CompletionStatus.notStarted)
                            Text("In Progress").tag(PunchListItem.CompletionStatus.inProgress)
                            Text("Complete").tag(PunchListItem.CompletionStatus.complete)
                        }
                        .pickerStyle(DefaultPickerStyle())
                    })
                })
                
                Section("Budget", content: {
                    HStack {
                        Text("Spent To-Date")
                        TextField("Spent To_Date", value: $renovationProject.budgetSpentToDate, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                    }
                })
            }
        }
        .navigationBarItems(
            leading: Button(action: {
                showingEditView = false
            }, label: {
                Text("Cancel")
            }),
                
            trailing: Button(action: {
                showingEditView = false
                editPublisher.send(renovationProject)
            }, label: {
                Text("Done")
            }))
    }
}

struct EditView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testProject = RenovationProject.testData[1]
        
        var body: some View {
            EditView(
                renovationProject: testProject,
                showingEditView: .constant(false),
                editPublisher: PassthroughSubject<RenovationProject, Never>()
            )
        }
    }
    
    static var previews: some View {
        Group {
            NavigationView {
                StatefulPreviewWrapper()
            }
            
            NavigationView {
                StatefulPreviewWrapper().preferredColorScheme(.dark)
            }
        }
    }
}
