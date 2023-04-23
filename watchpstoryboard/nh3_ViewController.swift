//
//  nh3_ViewController.swift
//  BLE WPLANT
//
//  Created by Viktor Horvat on 01.04.2023..
//

import UIKit
import Charts
import TinyConstraints

class nh3_ViewController: UIViewController {
    
    
    @IBOutlet weak var trenutna: UILabel!
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
        trenutna.text = String(Shared.instance.AllData[0].nh3)+" ppm"
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
        
        for i in (0...29){
            yValues.append(ChartDataEntry(x: Double(i), y: Shared.instance.AllData[i].temperature))
        }
        
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
