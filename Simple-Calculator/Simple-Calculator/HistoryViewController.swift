//
//  HistoryViewController.swift
//  Simple-Calculator
//
//  Created by Secrieru Andrei on 09.09.2022.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var historyTableView = UITableView()
    var array = [OperationHistory]()
    let identifier = "myCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        createTable()
    }
    
    func createTable(){
        historyTableView = UITableView(frame: view.bounds, style: .plain)
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        historyTableView.backgroundColor = UIColor(named: "backgroundColor")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearHistory(sender:)))
        historyTableView.delegate = self
        historyTableView.dataSource = self
        view.addSubview(historyTableView)
        }
    
    @objc func clearHistory(sender: Any) {
        array.removeAll()
        historyTableView.reloadData()
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let item = array[indexPath.row]
        cell.textLabel?.text = item.operation
        cell.backgroundColor = UIColor(named: "backgroundColor")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let vc = viewController as? ViewController {
            vc.operationArray = array
        }
    }
    
}
