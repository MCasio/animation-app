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
    
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }




}

// MARK: - Table View Delegates
extension ViewController: UITableViewDelegate {
    
}

// MARK: - Table View Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
