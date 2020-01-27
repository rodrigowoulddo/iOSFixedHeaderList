//
//  ViewController.swift
//  Fixed Header List
//
//  Created by Rodrigo on 27/01/2020.
//  Copyright © 2020 Rodrigo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Table View Constants
    private let NUMBER_OF_ROWS: Int = 256
    private let ROW_HEIGHT: CGFloat = 75.0
    private let CELL_IDENTIFIER: String = "cell"

    
    // MARK: - Header Constants
    private let MINIMUM_CONSTANT_VALUE: CGFloat = -150.0 /// This is the hidable view's height
    @IBOutlet weak var hidableViewTopConstraint: NSLayoutConstraint!

    private var lastContentOffset: CGFloat = 0.0

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NUMBER_OF_ROWS
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER) else { return UITableViewCell() }
            
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return ROW_HEIGHT
    }
    
}

// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = tableView.contentOffset.y - lastContentOffset
        
        let canScrollUp: Bool =
            delta < 0 &&
              hidableViewTopConstraint.constant < 0 &&
                scrollView.contentOffset.y < 0

        
        
        let canScrollDown: Bool =
            delta > 0 &&
              hidableViewTopConstraint.constant > MINIMUM_CONSTANT_VALUE &&
                tableView.contentOffset.y > 0
            
        
        if canScrollUp || canScrollDown{
                        
            hidableViewTopConstraint.constant -= delta
            tableView.contentOffset.y -= delta
            
        }
        
        lastContentOffset = tableView.contentOffset.y
        
    }
}

