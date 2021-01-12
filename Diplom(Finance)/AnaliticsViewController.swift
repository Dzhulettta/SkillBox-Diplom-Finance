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
        print("Категории сумма: \(countSumInCategory(item: "Продукты"))")
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.5, height:  self.view.frame.size.height / 1.5)
        pieChart.center = view.convert(CGPoint(x: self.view.center.x, y: self.view.frame.size.height / 3), from: view)

            //view.center
            //view.convert(CGPoint(x: 0, y: 0), from: view)
        view.addSubview(pieChart)
        var entries = [ChartDataEntry()]
        
        copyCoreDataHistory.appToCoreDate()
        let countUsedCategory = countCategory() as! Int//100%
        
        for x in 0 ..< countUsedCategory{
        //for x in 0 ..< 10{
            entries.append(ChartDataEntry(x: Double(100), y: Double(30)))
          
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
            var countArray: [String] = []
            for item in historyData{
                var itemOne = item.value(forKey: "label") as! String
                countArray.append(itemOne)
            }
            var filtered  = countArray.removeDuplicates()
            var count = filtered.count
            return count
            print("количество категорий: \(filtered), \(count)")
        }
       // print("количество категорий: \(count)")
        return count
    }
    // возвращает название категории и сумму затрат по категории
    func countSumInCategory(item: String)-> [String: Int]{
        copyCoreDataHistory.appToCoreDate()
        var countSum = 0
        var arrayForChart: [String: Int] = [:]
        let historyData = copyCoreDataHistory.coreDataHistory
        if historyData.count != 0{
            for i in 0 ... (historyData.count - 1){
                if item == historyData[i].value(forKey: "label") as! String{
                   let sum = historyData[i].value(forKey: "sum") as! String
                    countSum += (sum as! NSString).integerValue
                }
                arrayForChart.updateValue(countSum, forKey: item)
            }
            print(" Для Chart категории: \(arrayForChart)")
        }
        return arrayForChart
    }

}
// убирает из массива дубликаты
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
