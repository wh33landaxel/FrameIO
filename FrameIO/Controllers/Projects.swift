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
    
    var teamProjects : [String:[Project]] = [:]
    var sectionNames : [String] = []

    
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
                
                //Add team name attribute to projects since they are missing in the project payload
                if let teamData = projectsAndTeams.teams {
                    self.teams = teamData
                }
                
                let teamDict = Dictionary(uniqueKeysWithValues: self.teams.map({team in (team.id, team)}))
                
                for index in 0..<self.projects.count {
                    
                    self.projects[index].relationships.team.attributes = teamDict[self.projects[index].relationships.team.id]?.attributes ?? self.projects[index].relationships.team.attributes
                }
                
                //Sort projects by update time
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]

                self.projects = self.projects.sorted(by: { (project1, project2) -> Bool in
                    guard let project1UpdateTime = dateFormatter.date(from: project1.attributes.updatedAt),
                        let project2UpdateTime = dateFormatter.date(from: project2.attributes.updatedAt) else {
                        return false
                    }

                    return project1UpdateTime.compare(project2UpdateTime) == .orderedDescending
                })
                
                //Initialize Team Projects Variable to separate projects by team
                for project in self.projects {
                    
                    guard let teamName = project.relationships.team.attributes?.name else {
                        continue
                    }
                    
                    if self.teamProjects[teamName] != nil {
                        self.teamProjects[teamName]?.append(project)
                    } else {
                        self.teamProjects[teamName] = [project]
                    }
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
        var sectionCount = 0
        let hasRecents = projects.count > 5
        sectionCount = sectionCount + ((hasRecents) ? 1 + self.teamProjects.keys.count : self.teamProjects.keys.count)
        
        if hasRecents {
            sectionNames = ["Recents"]
            sectionNames.append(contentsOf: self.teamProjects.keys)
        } else {
            sectionNames.append(contentsOf: self.teamProjects.keys)
        }
        
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sectionNames.first == "Recents" && section == 0 {
            if self.projects.count < 10 && self.projects.count > 5 {
                return self.projects.count - 5
            } else {
                return 5
            }
        } else {
            return teamProjects[sectionNames[section]]?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        if sectionNames.first == "Recents" && indexPath.section == 0 {
            cell.textLabel?.text = self.projects[indexPath.row].attributes.name
            cell.detailTextLabel?.text = self.projects[indexPath.row].relationships.team.attributes?.name
        } else {
            let teamProject = teamProjects[sectionNames[indexPath.section]]
            
            cell.textLabel?.text = teamProject?[indexPath.row].attributes.name
            cell.detailTextLabel?.text = ""
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
}

