//
//  AreaChart.swift
//  Chart
//
//  Created by Daher Alfawares on 5/9/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit


class Quote {
    let Close : Double
    let Date  : Date
    
    init(close:Double,date:Date){
        Close = close
        Date = date
    }
    init(dictionary: [String:String]){
        self.Close =  Double(dictionary["Close"]!) ?? 0
        self.Date  =  Quote.date(string: dictionary["Date"]!)
    }
    
    static func date(string:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)!
    }
}


class LineData {
    
    var quotes = [Quote]()
    
    init(){
        do {
            let years = ["2008","2009","2010","2011","2012","2013","2014","2015","2016"]
            
            for year in years {
                let data = try Data(contentsOf:self.url(year:year))
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                
                let query   = json?["query"]
                let results = query?["results"]
                let quote   = results??["quote"]
                
                importTheData(array: (quote as? Array<AnyObject>)!)
            }
            
            sortTheData()
            //filterTheData()
            printTheData()
            
        } catch {
            
        }
    }
    
    func data() -> [Quote] {
        return quotes
    }
    
    func importTheData(array: [AnyObject]){
        
        for obj in array {
            let quote = Quote(dictionary: (obj as? [String:String])!)
            quotes.append(quote)
        }
    }
    
    func sortTheData(){
        quotes.sort { (q1, q2) -> Bool in
            return q1.Date.timeIntervalSince(q2.Date) < 0
        }
    }
    
    func filterTheData(){
        
        var remove = [Int]() // indecies to remove
        
        for (i,quote) in quotes.enumerated() {
            
            if i == 0 || i == quotes.count-1 {
                continue
            }
            
            let month = self.month(of: quote.Date)
            let nextMonth = self.month(of: quotes[i+1].Date)
            if month == nextMonth {
                remove.append(i)
            }
        }
        
        var removed = 0
        for i in remove {
            quotes.remove(at: i-removed)
            removed += 1
        }
    }
    
    func printTheData(){
        for quote in quotes {
            print("++++ \(quote.Date) \t\t: \(quote.Close)")
        }
    }
    
    func month(of date:Date) -> Int {
        let calendar = Calendar.current
        let component = calendar.component(Calendar.Unit.month, from: date)
        return component
    }
    
    let offline = true
    func url(year:String) -> URL {
        if offline {
            let path = Bundle.main.pathForResource("ACWI-\(year)-yql", ofType:"json")
            return URL(fileURLWithPath: path!)
        }
        
        return URL(
            string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%3D%22ACWI%22%20and%20startDate%3D%22\(year)-01-01%22%20and%20endDate%20%3D%20%22\(year)-12-31%22&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=")!
    }
}

