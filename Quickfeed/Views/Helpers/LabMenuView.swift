

import SwiftUI

struct LabMenuView: View {
    var labs: [StudentLab]
    var body: some View {
        VStack {
            ForEach(labs){ lab in
                Text(lab.labTitle)
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
