//
//  FakeProviderTests.swift
//  QuickfeedTests
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import XCTest
@testable import Quickfeed

class FakeProviderTests: XCTestCase {
    var sot: FakeProvider!

    override func setUpWithError() throws {
        sot = FakeProvider()
        
    }

    override func tearDownWithError() throws {
        sot = nil
    }

    func testFakeGetCoursesForStudent() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let courses: [Course]? = sot.getCoursesForCurrentUser()
        XCTAssertTrue(courses?.count == 2)
    }
    
    func testGetCourseById() throws {
        let course = sot.getCourseById(courseId: 111)
        XCTAssertEqual(course?.code, "DAT310")
        
        
    }
    
    func testInitCourseAssignments() throws{
        let course = sot.getCourseById(courseId: 111) // DAT310
        let assignments = course?.assignments
        
        XCTAssertEqual(assignments?.count, 3)
    }
    
    func testFakeGetUsersEnrolledInCourse() throws{
        let users: [User]? = sot.getUsersForCourse(courseId: 111)
        
        XCTAssertTrue(users?.count == 1)
        
       
    }


}
