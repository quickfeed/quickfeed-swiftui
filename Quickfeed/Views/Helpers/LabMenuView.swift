

import SwiftUI

struct LabMenuView: View {
    
    var labs: [AssignmentModel]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Labs")
                .padding(.leading)
                .font(.title2)
                .foregroundColor(.gray)
            
            ForEach(labs, id: \.id){ lab in
                HStack{
                    Text(lab.name)
                        .font(.title2)
                    Spacer()
                    if lab.isGroupLab {
                        Image(systemName: "person.3.fill")
                    }
                }
                .padding()
                .frame(minWidth: 200, idealWidth: 300, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct LabMenuView_Previews: PreviewProvider {
    static var labs: [AssignmentModel] = AssignmentModel.data
    static var previews: some View {
        LabMenuView(labs: labs)
    }
}
