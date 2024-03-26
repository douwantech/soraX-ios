//
//  ExploreController.swift
//  SoraX
//
//  Created by shuai on 2024/3/25.
//

import UIKit

class ExploreController: UIViewController {
    @IBOutlet weak var vTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .custom(.black15)
        vTable.backgroundColor = .clear
        vTable.delegate = self
        vTable.dataSource = self
        vTable.register(ExploreCategoryCell.nib, forCellReuseIdentifier: ExploreCategoryCell.reuseIdentifier)
        vTable.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: H.winWidth(), height: 69)))
    }
    
}

extension ExploreController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExploreCategoryCell.reuseIdentifier, for: indexPath) as! ExploreCategoryCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
