//
//  ViewTimes.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/14/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class ViewTimes: UIViewController {
  
  @IBOutlet weak var tableView0: UITableView!
  
  @IBOutlet weak var tableView1: UITableView!
  
  @IBOutlet weak var label0: UILabel!
  
  
  let travel = Travel()
  
  
  var timer: Timer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    delegates()
    startTimer()
    refreshData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    stopTimer()
  }
  
  
  
  func delegates() {
    tableView0.delegate = self
    tableView1.delegate = self
    
    tableView0.dataSource = self
    tableView1.dataSource = self
  }
  
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    timer.fire()
  }
  
  func stopTimer() {
    timer.invalidate()
    timer = nil
  }
  
  
  @objc func refreshData() {
    
    travel.refresh()
    
    //  Ref: https://ru-clip.net/video/whbyVPFFh4M/contacts-animations-reload-rows-in-uitableview-ep-2.html
    //  Ref: https://www.hackingwithswift.com/articles/80/how-to-find-and-fix-memory-leaks-using-instruments
    
    
    if travel.count(index: 0) != tableView0.numberOfRows(inSection: 0) ||
      travel.count(index: 1) != tableView1.numberOfRows(inSection: 0)
    {
      tableView0.reloadData()
      tableView1.reloadData()
      return
      
      
    }
    
    
    for i in 0..<travel.count(index: 0) {
      let indexPath = IndexPath(row: i, section: 0)
      tableView0.reloadRows(at: [indexPath], with: .left)
    }
    
    for i in 0..<travel.count(index: 1) {
      let indexPath = IndexPath(row: i, section: 0)
      tableView1.reloadRows(at: [indexPath], with: .bottom)
    }
    
    // tableView0.reloadData()
    // tableView1.reloadData()
    
    label0.text = "\(travel.getMinutes())"
    
    
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension ViewTimes: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    if tableView == tableView0 {
      return travel.count(index: 0)
    }
    
    if tableView == tableView1 {
      return travel.count(index: 1)
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    if tableView == tableView0 {
      
      if let cell = tableView.dequeueReusableCell(withIdentifier: "cell0") {
        
        let bgView: UIView = UIView(frame: CGRect(x: 2, y: 0, width: cell.bounds.width - 4, height: (cell.bounds.height)-2))
        
        bgView.backgroundColor = UIColor.gray
        bgView.layer.borderWidth = 3
        bgView.alpha = 1
        bgView.layer.cornerRadius = 9
        bgView.tag = 100
        
        bgView.center.x -=  view.bounds.width
        
        let label = UILabel(frame: CGRect(x:0, y:10, width:200, height:15))
        //label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.center
        
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.alpha = 10
        
        label.text = travel.msg(index: 0,row: indexPath.row)
        
        
        if  indexPath.row == 0 {
          switch travel.getMinutes()[0] {
          case let x where x < 10 && x >= 8:
            bgView.backgroundColor = UIColor.blue
          case let x where x < 8 && x >= 6:
            bgView.backgroundColor = UIColor.green
          case let x where x < 6 && x >= 5:
            bgView.backgroundColor = UIColor.yellow
          case let x where x < 5:
            bgView.backgroundColor = UIColor.red
          default:
            bgView.backgroundColor = UIColor.lightGray
          }
        } else {
          bgView.backgroundColor = UIColor.lightGray
        }
        
        
        
        //label.text = "title: \(indexPath.row)"
        label.tag = 101
        label.font  = UIFont(name: "Avenir", size: 17.0)
        
        bgView.addSubview(label)
        
        cell.addSubview(bgView)
        
        UIView.animate(withDuration: 0.5) {
          bgView.center.x += self.view.bounds.width
        }
        return cell
      }
      
    }
    
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
    
    
    let bgView: UIView = UIView(frame: CGRect(x: 15, y: 0, width: cell!.bounds.width - 20, height: 40))
    
    bgView.backgroundColor = UIColor.green
    bgView.layer.borderWidth = 1
    bgView.alpha = 1
    bgView.layer.cornerRadius = 9
    
    bgView.tag = 100
    
    bgView.center.x -=  view.bounds.width
    
    let bgViewM: UIView = UIView(frame: CGRect(x: 20, y: 3.4, width: 190, height: 29))
    
    bgViewM.backgroundColor = UIColor.white
    bgViewM.layer.borderWidth = 1
    bgViewM.alpha = 1
    bgViewM.layer.cornerRadius = 9
    bgViewM.tag = 300
    
    let label = UILabel(frame: CGRect(x:10, y:10, width:180, height:15))
    
    label.textAlignment = NSTextAlignment.center
    
    label.textColor = UIColor.black
    label.backgroundColor = UIColor.clear
    label.alpha = 10
    
    label.text = travel.msg(index: 1,row: indexPath.row)
    
    
    if  indexPath.row == 0 {
      switch travel.getMinutes()[1] {
      case let x where x <= 10 && x > 8:
        bgView.backgroundColor = UIColor.blue
      case let x where x <= 8 && x >= 6:
        bgView.backgroundColor = UIColor.green
      case let x where x < 6 && x >= 5:
        bgView.backgroundColor = UIColor.yellow
      case let x where x < 5:
        bgView.backgroundColor = UIColor.red
      default:
        bgView.backgroundColor = UIColor.lightGray
      }
    } else {
      bgView.backgroundColor = UIColor.lightGray
    }
    
    label.tag = 102
    label.font  = UIFont(name: "Avenir", size: 17.0)
    
    
    bgViewM.addSubview(label)
    bgView.addSubview(bgViewM)
    
    UIView.animate(withDuration: 0.5) {
      bgView.center.x += self.view.bounds.width
    }
    
    cell!.addSubview(bgView)
    
    return cell!
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    print("seleced")
  }
  
  
  
}





