//
//  AnaliticsViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 06.01.2021.
//
import Charts
import UIKit

class AnaliticsViewController: UIViewController, ChartViewDelegate {
    
    var copyCoreDataHistory = CoreDataHistory()
    var pieChart = PieChartView()
    
    @IBAction func next(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
          }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // countSumInCategory(item: 0)
        print("Категории сумма: \(countSumInCategory(item: "Label"))")
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.5, height:  self.view.frame.size.height / 1.5)
        pieChart.center = view.convert(CGPoint(x: self.view.center.x, y: self.view.frame.size.height / 3), from: view)

            //view.center
            //view.convert(CGPoint(x: 0, y: 0), from: view)
        view.addSubview(pieChart)
        var entries = [ChartDataEntry()]
        
        copyCoreDataHistory.appToCoreDate()
        let countUsedCategory = countCategory() //100%
        
        for x in 1 ... countUsedCategory{
        //for x in 0 ..< 10{
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
    // возвращает количество используемых категорий
    func countCategory()-> Int{
        copyCoreDataHistory.appToCoreDate()
        CoreDataHistory.shared.appToCoreDate()
        let historyData = copyCoreDataHistory.coreDataHistory
        var count = 1
        if historyData.count != 0{
            var count = 1
            var itemOne = historyData[0].value(forKey: "label") as! String
            for item in historyData{
                if itemOne != (item.value(forKey: "label") as! String){
                    count += 1
                    itemOne = item.value(forKey: "label") as! String
    }
            }
        }
        print("количество категорий: \(count)")
        return count
    }
    // возвращает сумму затрат по категории
    func countSumInCategory(item: String)-> Int{
        copyCoreDataHistory.appToCoreDate()
        var countSum = 0
        let historyData = copyCoreDataHistory.coreDataHistory
        if historyData.count != 0{
           // var item = historyData[item].value(forKey: "sum") as! String
            for i in 0 ... (historyData.count - 1){
                if item == historyData[i].value(forKey: "label") as! String{
                   let sum = historyData[i].value(forKey: "sum") as! String
                    countSum += (sum as! NSString).integerValue
                }
            }
            
        }
        return countSum
    }

}
