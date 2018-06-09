//
//  TableSection.swift
//  ErraticMinds
//
//  Created by Pedro Anibarro on 6/7/18.
//  Copyright © 2018 Pedro Anibarro. All rights reserved.
//

import Foundation
import UIKit

public protocol TableManagerDelegate: class {
    func didSelect(_ tableView: UITableView, at indexPath: IndexPath)
}

public extension TableManagerDelegate {
    func didSelect(_ tableView: UITableView, at indexPath: IndexPath) {}
}

public class TableManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    public weak var delegate: TableManagerDelegate?
    public var viewController: UIViewController? {
        return self.tableView.viewController()
    }
    public var tableView: UITableView {
        didSet {
            // Setup new table
            self.setupTable()
        }
    }
    public private(set) var sections: [TableSection] = [TableSection]()
    
    // MARK: - Initializers
    private init(tableView: UITableView) {
        // Set up table view
        self.tableView = tableView
    }
    
    convenience init(for tableView: UITableView, withSections sections: [TableSection.Type] = [TableSection.Type]()) {
        
        // Setup table
        self.init(tableView: tableView)
        self.setupTable()
        
        // Set up sections
        for (index, sectionType) in sections.enumerated() {
            let tableSection = sectionType.init(tableManager: self, section: index)
            self.sections.append(tableSection)
        }
        
    }
    
    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = self.sections[section].numberOfRows
        
        if numberOfRows == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
        
        return numberOfRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.sections[indexPath.section].getCell(forRowAt: indexPath.row)
    }
    
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(tableView, at: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sections[section].headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sections[section].headerHeight
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].title
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.sections[indexPath.section].getHeight(forRowAt: indexPath.row)
    }
    
}


// MARK: - Public Methods
public extension TableManager {
    
    func add(_ section: TableSection.Type, with animation: UITableViewRowAnimation = .automatic) {
        let indexOfSection = self.sections.count
        let section = section.init(tableManager: self, section: indexOfSection)
        self.sections.append(section)
        self.tableView.insertSections(IndexSet(integer: section.sectionIndex), with: animation)
    }
    
    func insert(_ section: TableSection.Type, atIndex index: Int, with animation: UITableViewRowAnimation = .automatic) {
        let section = section.init(tableManager: self, section: index)
        self.sections.insert(section, at: index)
        self.tableView.insertSections(IndexSet(integer: section.sectionIndex), with: animation)
    }
    
    func delete(_ section: TableSection) {
        let indexOfSection = self.sections.index { (tableSection) -> Bool in
            return tableSection.sectionIndex == section.sectionIndex
        }
        
        if let index = indexOfSection {
            self.sections.remove(at: index)
        }
        
        //Reload table
        self.reloadTable()
    }
    
    func delete(sectionAt index: Int) {
        self.sections.remove(at: index)
        
        //Reload table
        self.reloadTable()
    }
    
    func reloadTable() {
        
        // Reload sections data
        for section in self.sections {
            section.reloadData()
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func removeAllSections() {
        self.sections.removeAll()
        DispatchQueue.main.async {
            self.reloadTable()
        }
    }
    
    func reloadVisibleCells(with animation: UITableViewRowAnimation = .automatic) {
        
        DispatchQueue.main.async {
            // Get visible index paths
            if let indexPaths = self.tableView.indexPathsForVisibleRows {
                
                DispatchQueue.global().sync {
                    // Reload visible sections data
                    for indexPath in indexPaths {
                        self.sections[indexPath.section].reloadData()
                    }
                }
                
                // Reload visible cells
                self.tableView.reloadRows(at: indexPaths, with: animation)
                
            }
        }
        
    }
    
    func reload(sectionAt index: Int, with animation: UITableViewRowAnimation = .automatic) {
        
        if self.tableView.indexPathsForVisibleRows?.contains(where: { (indexPath) -> Bool in
            return indexPath.section == index
        }) ?? false {
            let indexSet = IndexSet(integer: index)
            self.tableView.reloadSections(indexSet, with: animation)
        }
        
    }
    
}

// MARK: - Private Methods
private extension TableManager {
    
    func setupTable() {
        
        // Set delegates and data sources
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Remove extra lines
        self.tableView.tableFooterView = UIView()
        
    }
    
}
