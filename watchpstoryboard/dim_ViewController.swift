//
//  dim_ViewController.swift
//  BLE WPLANT
//
//  Created by Viktor Horvat on 01.04.2023..
//

import UIKit
import Charts
import TinyConstraints

class dim_ViewController: UIViewController {

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
        let set1 = LineChartDataSet(entries: yValues)
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        
        
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
    }
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: 23.1),
        ChartDataEntry(x: 2.0, y: 24.1),
        ChartDataEntry(x: 3.0, y: 25.1),
        ChartDataEntry(x: 4.0, y: 26.1),
        ChartDataEntry(x: 5.0, y: 25.1),
        ChartDataEntry(x: 6.0, y: 24.1),
        ChartDataEntry(x: 7.0, y: 23.5),
        ChartDataEntry(x: 8.0, y: 23.1),
        ChartDataEntry(x: 9.0, y: 22.8),
        ChartDataEntry(x: 10.0, y: 23.3),
        ChartDataEntry(x: 11.0, y: 26.1),
        ChartDataEntry(x: 12.0, y: 25.1),
        ChartDataEntry(x: 13.0, y: 24.1),
        ChartDataEntry(x: 14.0, y: 23.1),
        ChartDataEntry(x: 15.0, y: 24.1),
        ChartDataEntry(x: 16.0, y: 25.1),
        ChartDataEntry(x: 17.0, y: 26.1),
        ChartDataEntry(x: 18.0, y: 25.1),
        ChartDataEntry(x: 19.0, y: 24.1),
        ChartDataEntry(x: 20.0, y: 22.1),
        ChartDataEntry(x: 21.0, y: 23.1),
        ChartDataEntry(x: 22.0, y: 24.1),
        ChartDataEntry(x: 23.0, y: 25.1),
        ChartDataEntry(x: 24.0, y: 26.1),
        ChartDataEntry(x: 25.0, y: 25.1),
        ChartDataEntry(x: 26.0, y: 24.1),
        
    ]
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
