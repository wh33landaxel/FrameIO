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
    var projects: [Project] = []
    var teams: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PROJECTS"
        getProjects()
    }
    
    func getProjects() {
        NetworkLayer.request(router: .getUserProjects, completion: { (result:Result<ProjectsAndTeams, Error>) in
            
            switch result {
            case .success(let projectsAndTeams):
                guard let projectData = projectsAndTeams.projects else {
                    return
                }
                
                self.projects = projectData
                
                if let teamData = projectsAndTeams.teams {
                    self.teams = teamData
                }
                
                let teamDict = Dictionary(uniqueKeysWithValues: self.teams.map({team in (team.id, team)}))
                
                for index in 0..<self.projects.count {
                    
                    self.projects[index].relationships.team.attributes = teamDict[self.projects[index].relationships.team.id]?.attributes ?? self.projects[index].relationships.team.attributes
                }
                                
                DispatchQueue.main.async {
                    self.projectsTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
            
        })
    }
}

extension Projects: UITableViewDelegate, UITableViewDataSource {
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return projects.count > 5 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.numberOfSections == 2 {
            if section == 0 {
                return 5
            } else {
                return projects.count - 5
            }
        }
        
        return projects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = projects[indexPath.row].attributes.name
        cell.detailTextLabel?.text = projects[indexPath.row].relationships.team.attributes?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.numberOfSections == 2 {
            
            if section == 0 {
                return "Recent Projects"
            } else {
                return "Projects"
            }
        } else {
            return "Projects"
        }
    }
}

