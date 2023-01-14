
import SwiftUI

struct RenovationProjectsView: View {
    @StateObject var projectsPublisher: RenovationProjectsPublisher;
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(projectsPublisher.renovationProjects, id: \.projectNumber) { project in
                    let projectIndex = projectsPublisher.renovationProjects.firstIndex(where: { $0.id == project.id })!
                    NavigationLink(
                        destination: DetailView(renovationProject: $projectsPublisher.renovationProjects[projectIndex]),
                        label: { RenovationProjectRow(renovationProject: project) })
                }
            }
        }
    }
}

struct RenovationProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        RenovationProjectsView(projectsPublisher: RenovationProjectsPublisher())
    }
}
