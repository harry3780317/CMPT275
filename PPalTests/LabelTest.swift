//
//  LabelTest.swift
//  PPalTests
//
//  Created by rclui on 10/24/17.
//  Copyright © 2017 CMPT275. All rights reserved.
//

import Foundation
import XCTest
@testable import PPal

/**
 # LabelTest Class
 This class contains the XCTests for the Label class methods, and additionally
 requires the following classes:
 - Person class (from PPal)
 
 Edit: This class does not have dependencies for the Person class.  The intial
 setUp() and tearDown() methods used it, but the test cases themselves do not.
 They are located in the PersonLabelTest class.
 */
class LabelTest: XCTestCase {
    var label01: Label? = Label()
    var label02: Label? = Label()
    var person01: Person? = Person()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        label01 = Label()
        label02 = Label()
        person01 = Person()
        _ = person01?.setInfo(pathToPhoto: "aPathToAPhoto.jpg", firstName: "Ryan", lastName: "Lui", phoneNumber: "+16041234567", email: "rclui@sfu.ca", address: "123 Fake Street", hasHouseKeys: false)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        label01?.clearAll()
        label02?.clearAll()
        person01?.clearAll()
        label01 = nil
        label02 = nil
        person01 = nil
    }
    
    /// Test to see if we can change the name of a label to be blank.
    func testEditLabelNameButBlankName() {
        let result = label01!.editLabel(name: "")
        
        XCTAssertFalse(result, "You managed to change the label name to be blank!")
    }
    
    /// Test to see if we can change the name of a label to contain a comma.
    func testEditLabelNameButContainsComma() {
        let result = label01!.editLabel(name: "Test,")
        
        XCTAssertFalse(result, "You managed to change the label name to contain a comma!")
    }
    
    /// Test to see if we can create two labels, and change them to the same name.
    func testEditLabelNameButSameName() {
        _ = label01?.editLabel(name: "Family")
        
        // This should fail because Family already exists.
        let result02 = label02!.editLabel(name: "Family")
        
        XCTAssertFalse(result02, "You managed to set the name even though you're not supposed to!")
        
    }
    
    /**
     Test to see if we can create two labels:
     - Change the first label to Test.
     - Overwrite the original label with a new one, so it gets destroyed.
     - Change the second label to Test.
     */
    func testEditLabelNameSameNameButOriginalObjectReplaced() {
        label01!.editLabel(name: "Family")
        
        label01 = nil
        
        // This should succeed because the reference to the original Label with family no longer
        // has a reference.
        let result02 = label02!.editLabel(name: "Family")
        
        XCTAssertTrue(result02, "You can't change the name even though this name doesn't exist!")
    }
    
    /// Test to see if the valid { get } is working correctly.
    func testValidBoolean() {
        
        XCTAssertFalse(label01!.valid, "The label is valid even though there's no name!")
        
        _ = label01?.editLabel(name: "Family")
        
        // It should be okay now.
        XCTAssertTrue(label01!.valid, "The label is supposed to be valid!")
        
    }
    
}
