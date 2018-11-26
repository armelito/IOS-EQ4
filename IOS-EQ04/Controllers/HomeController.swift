//
//  HomeController.swift
//  IOS-EQ04
//
//  Created by Quentin on 10/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CoreCharts


class HomeController: UIViewController, UITabBarDelegate, CoreChartViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barCharts: VCoreBarChart!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var addDrinkItem: UITabBarItem!
    
    let statistics1 = [1, 1, 1, 1, 1, 1]
    let statistics2 = [1, 1, 1, 2, 1, 1]
    let statistics3 = [1, 1, 3, 1, 1, 1]
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            loadCoreChartData(statistics1);
        case 1:
            loadCoreChartData(statistics2);
        case 2:
            loadCoreChartData(statistics3);
        default:
            break
        }
    }
    
    var parties: [Party] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.delegate = self
        
        parties = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        
        barCharts.dataSource = self

        barCharts.displayConfig.barWidth = 30
        barCharts.displayConfig.barSpace = 12
        barCharts.displayConfig.titleFontSize = 16
        barCharts.displayConfig.valueFontSize = 16
    }
    
    func loadCoreChartData(_ statistics: Array<Int>) -> [CoreChartEntry] {
        var allData = [CoreChartEntry]()
        
        let days = ["M","T","W","T", "F", "S", "S"]
        
        for index in 0..<days.count {
            
            let newEntry = CoreChartEntry(id: "\(statistics[index])",
                barTitle: days[index],
                barHeight: Double(statistics[index]),
                barColor: UIColor.white.withAlphaComponent(0.5))
            
            
            allData.append(newEntry)
            
        }
        return allData
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == addDrinkItem {
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let AddDrinkController = myStoryboard.instantiateViewController(withIdentifier: "AddDrinkController")
            self.present(AddDrinkController, animated: false, completion: nil)
        }
    }

}


// Configuration for the parties table
extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func createArray() -> [Party] {
        
        var tempData: [Party] = []
        
        let party1 = Party(litres: 4.5, date: "12 Nov. 2018")
        let party2 = Party(litres: 3.0, date: "10 Nov. 2018")
        
        tempData.append(party1)
        tempData.append(party2)
        
        return tempData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let party = parties[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell") as! PartyTableViewCell
        
        cell.setParty(party: party)
        
        return cell
    }
    
}
