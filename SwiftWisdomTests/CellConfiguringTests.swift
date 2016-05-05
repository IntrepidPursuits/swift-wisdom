//
//  CellConfiguringTests.swift
//  SwiftWisdom
//
//  Created by Ying Quan Tan on 5/5/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest

private class TestCell: UITableViewCell {}
private let TestCellIdentifier = "TestCell"

class CellConfiguringTests: XCTestCase, UITableViewDataSource {

    var testTableView: UITableView!
    var rows = ["Hello"]
    
    override func setUp() {
        super.setUp()
        testTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        testTableView.dataSource = self
    }

    func testIpCellForRowAtIndexPath() {
        testTableView.registerClass(TestCell.self, forCellReuseIdentifier: TestCellIdentifier)
        testTableView.reloadData()
        let cell = testTableView.ip_cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        XCTAssert(cell is TestCell)
    }

    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TestCellIdentifier)!
        return cell
    }
}
