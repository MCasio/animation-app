//
//  ViewController.swift
//  animation-app
//
//  Created by Mahmoud Mohammed on 8/19/18.
//  Copyright © 2018 Mahmoud Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

// MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
// MARK: - Properties
    let duration = 0.8
    fileprivate let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position", "Color and Frame Change", "View Fade In", "Pop"]
    
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTableView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.backBarButtonItem?.title = items[indexPath.row]
    }
    
    
    func animateTableView() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHight = tableView.bounds.size.height
        
        // move all cells to the bottom of the screen
        for cell in cells {
            cell.transform = CGAffineTransform(scaleX: 0, y: tableHight)
        }
        
        //move all cells from the bottom to the right place
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: duration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }


// MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_DETAIL_VC {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let detailVC = segue.destination as? DetailViewController {
                detailVC.barTitle = items[indexPath.row]
            }
        }
    }

}

// MARK: - Table View Delegates
extension ViewController: UITableViewDelegate {
    
}

// MARK: - Table View Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ANIMATION_CELL) else { return UITableViewCell() }
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.2258775234, green: 0.8100398183, blue: 0.5215207934, alpha: 1)
        
        return cell
    }
}


















