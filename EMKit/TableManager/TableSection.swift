//
//  TableSection.swift
//  ErraticMinds
//
//  Created by Pedro Anibarro on 6/7/18.
//  Copyright © 2018 Pedro Anibarro. All rights reserved.
//

import Foundation
import UIKit

public protocol TableSection: class {
    
    // MARK: - Properties
    var tableManager: TableManager! { get }
    var sectionIndex: Int! { get }
    var title: String? { get }
    var numberOfRows: Int { get }
    var headerView: UIView? { get }
    var headerHeight: CGFloat { get }
    
    // MARK: - Methods
    init(tableManager: TableManager, section: Int)
    func getCell(forRowAt index: Int) -> UITableViewCell
    func getHeight(forRowAt index: Int) -> CGFloat
    func setupTable()
    func reloadData()
    func registerCells()
    
}

public extension TableSection {
    func registerCells() {}
}
