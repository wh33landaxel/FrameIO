//
//  ViewController.swift
//  FrameIO
//
//  Created by Axel Nunez on 11/7/19.
//  Copyright © 2019 Axel Nunez. All rights reserved.
//

import UIKit

class Projects: UIViewController {
    @IBOutlet weak var projectsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PROJECTS"
    }
    
  
}

extension Projects: UITableViewDelegate, UITableViewDataSource {
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

