
import SwiftUI

struct test: View {
    var student: UserModel
    var courses: [CourseModel]
    @State private var selectedCourse = 1

    var body: some View {
        NavigationView{
            List{
                Picker(selection: $selectedCourse, label: Text("Current course")) {
                    ForEach(courses, id: \.id){ course in
                        NavigationLink(destination: Text(course.code)){
                            Text(course.code)
                        }
                    }
                }
                .frame(width: .infinity)
                .pickerStyle(MenuPickerStyle())
                .labelsHidden()
                
                TestLabMenyView(selectedCourse: selectedCourse, labs: AssignmentModel.data)
            }
        }
    }
}

struct test_Previews: PreviewProvider {
    static var student = UserModel.data[0]
    static var coures = CourseModel.data
    static var previews: some View {
        test(student: student, courses: coures)
    }
}


struct TestLabMenyView: View {
    var selectedCourse: Int
    var labs: [AssignmentModel]
    
    var body: some View {
        Text("Labs")
        ForEach(labs, id: \.id){ lab in
            if lab.courseId == selectedCourse{
                NavigationLink(destination: testStudentView(lab: lab, side: lab.id, scoreLimit: lab.scoreLimit)){
                    Text(lab.name)
                    Spacer()
                    if lab.isGroupLab {
                        Image(systemName: "person.3.fill")
                    }
                }
            }
        }
    }
}

struct TestLabMenuView_Previews: PreviewProvider {
    static var labs: [AssignmentModel] = AssignmentModel.data
    static var previews: some View {
        TestLabMenyView(selectedCourse: 0, labs: labs)
    }
}


