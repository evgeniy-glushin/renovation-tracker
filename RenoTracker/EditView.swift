
import SwiftUI
import Combine

struct EditView: View {
    @Binding var renovationProject: RenovationProject
    var editPublisher: PassthroughSubject<RenovationProject, Never>
    
    var body: some View {
        VStack {
            Text("Hi from edit view")
            
            Button("publish", action: {
                var new = renovationProject
                new.isFlagged = !new.isFlagged
                editPublisher.send(new)
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State private var testProject = RenovationProject.testData[1]
        
        var body: some View {
            EditView(renovationProject: $testProject, editPublisher: PassthroughSubject<RenovationProject, Never>())
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
