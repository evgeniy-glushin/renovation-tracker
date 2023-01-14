
import SwiftUI

struct RenovationProjectRow: View {
    let renovationProject: RenovationProject
    
    var body: some View {
        VStack {
            HStack {
                Image(renovationProject.imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                VStack (alignment: .leading) {
                    Text(renovationProject.renovationArea).font(.headline)
                    
                    Label(renovationProject.formattedDueDate, systemImage: "calendar")
                    Label("\(renovationProject.totalPunchListItems) items", systemImage: "wrench.and.screwdriver.fill")
                    Label(renovationProject.formattedPercentComplete, systemImage: "percent")
                    Label("\(renovationProject.budgetAmountRemaining < 0 ? "Over budget" : "On budget")", systemImage: "dollarsign.circle")
                        .foregroundColor(renovationProject.budgetAmountRemaining < 0 ? .red : .accentColor)
                }.foregroundColor(.accentColor)
                
                Spacer()
            }
            
        }
    }
}

struct RenovationProjectRow_Previews: PreviewProvider {
    static var previews: some View {
        RenovationProjectRow(renovationProject: RenovationProject.testData[0])
    }
}
