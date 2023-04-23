//
//  temperatura_ViewController.swift
//  BLE WPLANT
//
//  Created by Viktor Horvat on 01.04.2023..
//

import UIKit
import Charts
import TinyConstraints


class temperatura_ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var temepraturaBIGicon: UIImageView!
    
    @IBOutlet weak var chartView: UIView!
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        
        chartView.rightAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(5, force: false)
        yAxis.labelTextColor = .black
        yAxis.labelAlignment = .justified
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.labelPosition = .bottom
        
        chartView.animate(xAxisDuration: 1.5)
        
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        
        chartView.legend.enabled = false
        
        
        
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Temperatura")
        // Do any additional setup after loading the view.
        
        chartView.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.widthToSuperview()
        lineChartView.heightToSuperview()
        setData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData(){
        var yValues: [ChartDataEntry] = []
        
//        for i in (0...29){
//            yValues.append(ChartDataEntry(x: Double(i), y: Shared.instance.AllData[i].temperature))
//        }
        yValues.append(ChartDataEntry(x: 1, y: 19.2))
        yValues.append(ChartDataEntry(x: 2, y: 17.4))
        yValues.append(ChartDataEntry(x: 3, y: 15.2))
        yValues.append(ChartDataEntry(x: 4, y: 14.3))
        yValues.append(ChartDataEntry(x: 5, y: 12.1))
        yValues.append(ChartDataEntry(x: 6, y: 11.6))
        yValues.append(ChartDataEntry(x: 7, y: 9.3))
        yValues.append(ChartDataEntry(x: 8, y: 7.9))
        yValues.append(ChartDataEntry(x: 9, y: 6.8))
        yValues.append(ChartDataEntry(x: 10, y: 6.2))
        yValues.append(ChartDataEntry(x: 11, y: 6.1))
        yValues.append(ChartDataEntry(x: 12, y: 6.0))
        yValues.append(ChartDataEntry(x: 13, y: 5.8))
        yValues.append(ChartDataEntry(x: 14, y: 5.8))
        yValues.append(ChartDataEntry(x: 15, y: 5.9))
        yValues.append(ChartDataEntry(x: 16, y: 7.2))
        yValues.append(ChartDataEntry(x: 17, y: 8.3))
        yValues.append(ChartDataEntry(x: 18, y: 9.7))
        yValues.append(ChartDataEntry(x: 19, y: 11.2))
        yValues.append(ChartDataEntry(x: 20, y: 14.2))
        yValues.append(ChartDataEntry(x: 21, y: 16.7))
        yValues.append(ChartDataEntry(x: 22, y: 17.1))
        yValues.append(ChartDataEntry(x: 23, y: 17.2))
        yValues.append(ChartDataEntry(x: 24, y: 17.8))
        yValues.append(ChartDataEntry(x: 25, y: 17.9))
        yValues.append(ChartDataEntry(x: 26, y: 17.1))
        yValues.append(ChartDataEntry(x: 27, y: 16.5))
        yValues.append(ChartDataEntry(x: 28, y: 16.2))
        yValues.append(ChartDataEntry(x: 29, y: 16.1))
        yValues.append(ChartDataEntry(x: 30, y: 15.6))
        yValues.append(ChartDataEntry(x: 31, y: 14.3))
        yValues.append(ChartDataEntry(x: 32, y: 14.3))
        yValues.append(ChartDataEntry(x: 33, y: 12.1))
        yValues.append(ChartDataEntry(x: 34, y: 11.6))
        yValues.append(ChartDataEntry(x: 35, y: 9.3))
        yValues.append(ChartDataEntry(x: 36, y: 7.9))
        yValues.append(ChartDataEntry(x: 37, y: 6.8))
        yValues.append(ChartDataEntry(x: 38, y: 6.2))
        yValues.append(ChartDataEntry(x: 39, y: 6.1))
        yValues.append(ChartDataEntry(x: 40, y: 6.0))
        yValues.append(ChartDataEntry(x: 41, y: 5.8))
        yValues.append(ChartDataEntry(x: 42, y: 5.8))
        yValues.append(ChartDataEntry(x: 43, y: 5.9))
        yValues.append(ChartDataEntry(x: 44, y: 7.2))
        yValues.append(ChartDataEntry(x: 45, y: 8.3))
        yValues.append(ChartDataEntry(x: 46, y: 9.7))
        yValues.append(ChartDataEntry(x: 47, y: 11.2))
        yValues.append(ChartDataEntry(x: 48, y: 14.2))

        
        
        
        
        
        
        
        print(yValues)
        
        
        let set1 = LineChartDataSet(entries: yValues)
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        
        
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
        
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
