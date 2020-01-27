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
    
    /// Table View Constants //////////////////////////////////////////////////
    private let NUMBER_OF_ROWS: Int = 20
    private let ROW_HEIGHT: CGFloat = 75.0
    private let CELL_IDENTIFIER: String = "cell"
    ///////////////////////////////////////////////////////////////////////////////////////
    
    
    /// Header Constants ///////////////////////////////////////////////////////
    private let MINIMUM_CONSTANT_VALUE: CGFloat = -150.0 /// This is the hidable view's height
    @IBOutlet weak var hidableViewTopConstraint: NSLayoutConstraint!

    private var lastContentOffset: CGFloat = 0.0
    ///////////////////////////////////////////////////////////////////////////////////////


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NUMBER_OF_ROWS
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER) {
            
            return cell
        }
        else {
            
            return UITableViewCell()
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return ROW_HEIGHT
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = tableView.contentOffset.y - lastContentOffset
        
        
        if delta < 0 {
            /// the value is negative, so we're scrolling up and the view is moving back into view.
            /// take whatever is smaller, the constant minus delta or 0
            
            hidableViewTopConstraint.constant = min(hidableViewTopConstraint.constant - delta, 0)
            
        } else {
            /// the value is positive, so we're scrolling down and the view is moving out of sight.
            /// take whatever is "larger," the constant minus delta, or the minimumConstantValue.
            
            hidableViewTopConstraint.constant = max(MINIMUM_CONSTANT_VALUE, hidableViewTopConstraint.constant - delta)
        }
    }
}

