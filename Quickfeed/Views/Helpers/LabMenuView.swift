

import SwiftUI

struct LabMenuView: View {
    var labs: [StudentLab]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Labs")
                .padding(.leading)
                .font(.title2)
                .foregroundColor(.gray)
            
            ForEach(labs){ lab in
                HStack{
                    Text(lab.labTitle)
                        .font(.title2)
                    Spacer()
                    Image(systemName: "person.3.fill")
                }
                .padding()
                

                
                
            }
            
        }
    }
}

struct LabMenuView_Previews: PreviewProvider {
    static var course: StudentCourse = StudentCourse.data[0]
    static var previews: some View {
        LabMenuView(labs: course.labs)
    }
}
