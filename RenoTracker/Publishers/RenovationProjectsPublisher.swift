
import Foundation
import Combine

class RenovationProjectsPublisher : ObservableObject {
    private let dataService = RenovationProjectDataService();
    private var cancellation = Set<AnyCancellable>()
    @Published var renovationProjects = [RenovationProject]()
    
    init() {
        
        dataService.load()
            .sink { completion in
                print("loaded... \(completion)")
            } receiveValue: { loadedProjects in
                self.renovationProjects = loadedProjects
            }.store(in: &cancellation)
    }
}
