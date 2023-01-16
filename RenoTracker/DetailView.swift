
import SwiftUI
import Combine

struct DetailView: View {
    @Binding var renovationProject: RenovationProject
    @State private var showingEditView = false
    private let editPublisher = PassthroughSubject<RenovationProject, Never>()
    
    var body: some View {
        VStack (alignment: .leading) {
            Header(renovationProject: renovationProject)
           
            WorkQuility(renovationProject: renovationProject)
            
            PunchList(renovationProject: renovationProject)
            
            Divider()
            
            Budget(renovationProject: renovationProject)
        }.navigationTitle("Front Lobby")
         .padding()
         .navigationBarItems(trailing: Button(action: {
             showingEditView = true
         }, label: {
             Text("Edit")
         }))
         .sheet(isPresented: $showingEditView, content: {
             NavigationStack {
                 EditView(
                    renovationProject: renovationProject,
                    showingEditView: $showingEditView,
                    editPublisher: editPublisher)
             }
         }).onReceive(editPublisher) { renovationProject = $0 }
    }
}
    
struct Header: View {
    let renovationProject: RenovationProject
    
    var body: some View {
        VStack {
            Image(renovationProject.imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 5)
                .overlay(
                    Text(renovationProject.isFlagged ? "FLAGGED FOR REVIEW" : "")
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.8))
                        .padding(),
                    alignment: .topTrailing)
                .overlay (alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 5)
                }.overlay(alignment: .bottom) {
                    ProgressInfo(renovationProject: renovationProject)
                        .padding()
                }
        }
    }
}

struct ProgressInfo: View {
    let renovationProject: RenovationProject
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.6)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack {
                HStack {
                    ProgressView(value: renovationProject.percentComplete)
                        .padding(.leading)
                    
                    Text("\(renovationProject.formattedPercentComplete) Complete")
                        .font(.caption)
                        .padding(.trailing)
                }
                Text("Due on \(renovationProject.formattedDueDate)")
            }
        }.frame(width: 310, height: 100)
    }
}

struct WorkQuility: View {
    let renovationProject: RenovationProject
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Work Quality")
                .font(.headline)
                .foregroundColor(.accentColor)
            
            workQualitySymbol
                .foregroundColor(Color.yellow)
            
            Divider()
        }
    }
    
    var workQualitySymbol: some View {
        HStack {
            // First Star
            if [.poor, .fair, .good, .excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
            } else {
                Image(systemName: "star")
            }
            
            // Second Star
            if [.fair, .good, .excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
                    .transition(.opacity)
            } else {
                Image(systemName: "star")
            }
            
            // Third Star
            if [.good, .excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
                    .transition(.opacity)
            } else {
                Image(systemName: "star")
            }
            
            // Fourth Star
            if [.excellent].contains(renovationProject.workQuality) {
                Image(systemName: "star.fill")
                    .transition(.opacity)
            } else {
                Image(systemName: "star")
            }
        }
    }
}

struct PunchList: View {
    let renovationProject: RenovationProject
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Punch List")
                .font(.headline)
                .foregroundColor(.accentColor)

            ForEach(renovationProject.punchList, id: \.task) { item in
                Label(
                    title: { Text(item.task) },
                    icon: { item.completionStatusSymbol })
            }
        }
    }
}

struct Budget: View {
    var renovationProject: RenovationProject
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Budget")
                .font(.headline)
                .foregroundColor(.accentColor)

            Label(
                title: { Text(renovationProject.budgetStatus.rawValue) },
                icon: { renovationProject.budgetStatusSymbol.foregroundColor(renovationProject.budgetStatusForegroundColor) }
            )
            
            HStack {
                Text("Amount Allocated:")
                Spacer()
                Text(renovationProject.formattedBudgetAmountAllocated)
            }
            
            HStack {
                Text("Spent to-date:")
                Spacer()
                Text(renovationProject.formattedBudgetSpentToDate).underline()
            }
            
            HStack {
                Text("Amount remaining:")
                Spacer()
                Text(renovationProject.formattedBudgetAmountRemaining).bold()
            }
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testProject = RenovationProject.testData[1]
        
        var body: some View {
            DetailView(renovationProject: $testProject)
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
