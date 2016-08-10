//
//  ViewController.swift
//  CompoundBarChart
//
//  Created by Daher Alfawares on 4/18/16.
//  Copyright © 2016 Daher Alfawares. All rights reserved.
//

import UIKit

class Color {
    
    internal class func tag(_ tag: UInt32) -> UIColor {
        typealias F = CGFloat
        let r = (tag & 0xFF0000) >> 16
        let g = (tag & 0x00FF00) >> 8
        let b = (tag & 0x0000FF)
        let c = F(255.0)
        return UIColor(red:F(r)/c,green:F(g)/c,blue:F(b)/c,alpha:1.0)
    }
    
    // Palette Style
    class func brand           ()->UIColor { return Color.tag( 0x115740 ) }
    class func action          ()->UIColor { return Color.tag( 0x3a913f ) }
    class func alert           ()->UIColor { return Color.tag( 0xe57200 ) }
    class func secondaryAction ()->UIColor { return Color.tag( 0x005082 ) }
    class func bodyText        ()->UIColor { return Color.tag( 0x444444 ) }
    class func secondaryText   ()->UIColor { return Color.tag( 0x828282 ) }
    class func accent          ()->UIColor { return Color.tag( 0xcfcfcf ) }
    class func background      ()->UIColor { return Color.tag( 0xf2f0ed ) }
    class func highlight       ()->UIColor { return Color.tag( 0xf1c400 ) }
    class func data            ()->UIColor { return Color.tag( 0x6bcaba ) }
    
    
    // associations:
    class func riskControl     ()->UIColor { return Color.tag( 0x8eb1c7 )   }
    class func capitalAsset    ()->UIColor { return Color.tag( 0x64a541 )   }
    class func portfolio       ()->UIColor { return Color.tag( 0xe2e2e2 )   }
    class func annuities       ()->UIColor { return Color.tag( 0x5a2864 )   }
    class func other           ()->UIColor { return Color.tag( 0xaa2d28 )   }
    class func trustIncome     ()->UIColor { return Color.tag( 0xd2aad2 )   }
    class func annuitiesColor  ()->UIColor { return Color.tag( 0x5a2864 )   }
    class func inflows         ()->UIColor { return Color.action()          }
    class func socialSecurity  ()->UIColor { return Color.secondaryAction() }
    class func pension         ()->UIColor { return Color.data()            }
    class func contingent      ()->UIColor { return Color.background()      }
    class func portfolioReserve()->UIColor { return Color.background()      }
}

class Sample {
    let period : [Double] = [40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80]
    
    let lifestyleSpending1 : [Double] = [500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,500000,0,0,0,0,0,0,0,0,0]
    let lifestyleSpending2 : [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,600000,600000,600000,600000,600000,600000,600000,600000,600000]
    
    let socialSecurity : [Double] = [400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,400000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    let pension : [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,132454.2986,129131.1739,125891.4226,122732.9528,119653.7254,116651.7523,113725.0951,110871.8644,108090.218,105378.3598,102734.539,100157.0486,97644.22449,95194.44418,92806.12601,90477.72798]
    
    let socialSecurity_Real : [Double] = [0,0,0,0,0,0,0,0,110,110,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,46660.70091,45490.03806,44348.74578,43236.0872,42151.34393,41093.81561,40062.81946,39057.68979,38077.77767,37122.4504,36191.09119]
    
    let portfolioSpending : [Double] = [100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,100000,500000,500000,500000,500000,500000,500000,500000,250000,250000,250000,250000,250000,150000,150000,150000,150000,150000,150000,150000,150000,150000,150000,150000]
    
    let portfolioReserve : [Double] = [100000,100000,100000,100000,100000,100000,100000,100000,500000,500000,100000,100000,100000,100000,100000,100000,100000,100000,500000,500000,500000,500000,500000,500000,500000,367545.7014,370868.8261,374108.5774,377267.0472,380346.2746,336687.5468,340784.8668,344779.3898,348673.6948,352470.2962,356171.6454,359780.1319,363298.0857,366727.7782,370071.4236,373331.1808]
}


class ViewController: UIViewController {
    
    @IBOutlet weak var bar1: CompoundBar!
    @IBOutlet weak var bar2: CompoundBar!
    
    @IBOutlet weak var circle1: Circle!
    @IBOutlet weak var circle2: Circle!
    
    @IBOutlet weak var line: Line!
    @IBOutlet weak var area: Area!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        area.model = Area.Model(
            Back: [
                Area.Element( Values: Sample().lifestyleSpending1, Color: Color.portfolio()),
                Area.Element( Values: Sample().lifestyleSpending2, Color: Color.portfolio())
            ],
            
            Rows: [
                Area.Element( Values: Sample().socialSecurity_Real, Color: Color.socialSecurity()),
                Area.Element( Values: Sample().pension,             Color: Color.pension()),
                Area.Element( Values: Sample().socialSecurity,      Color: Color.action()),
                ]
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.createPDFfromUIView(self.view, saveToDocumentsWithFileName: "test.pdf")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let animate = true
    
    let v1 : [Double] = [ 20, 40,  100,  56,  90,  20,  30 ]
    let v2 : [Double] = [ 80, 1000, 10,   0,  30, 400,  50 ]
    let v3 : [Double] = [ 10, 40,   10, 300, 200, 100, 300 ]
    let t1 : [Double] = [ 20, 40,  180, 156,  90,  20,  30 ]
    let t2 : [Double] = [ 20, 100,  10,   0,  30,  40,  50 ]
    let t3 : [Double] = [ 40, 80,  152,  30,  20, 100, 300 ]
    let ld = LineData()
    
    @IBAction func b1(_ sender: AnyObject) {
        bar1.setValues(v1, animated: animate)
        bar2.setValues(t1, animated: animate)
        
        circle1.userData = v1
        circle2.userData = t1
        
        line.setValues(ld.data(), animated: animate, startFrom: Date(timeIntervalSinceNow: -60*60*24*256))
    }
    
    @IBAction func b2(_ sender: AnyObject) {
        bar1.setValues(v2, animated: animate)
        bar2.setValues(t2, animated: animate)
        
        line.setValues(ld.data(), animated: animate, startFrom: Date(timeIntervalSinceNow: -60*60*24*256*3))
    }
    @IBAction func b3(_ sender: AnyObject) {
        bar1.setValues(v3, animated: animate)
        bar2.setValues(t3, animated: animate)
        
        line.setValues(ld.data(), animated: animate, startFrom: Date(timeIntervalSinceNow: -60*60*24*256*5))
    }
    
    @IBAction func b4(_ sender: AnyObject) {
        line.setValues(ld.data(), animated: animate, startFrom: Date(timeIntervalSinceNow: -60*60*24*256*10))
    }
    
    func createPDFfromUIView(_ aView:UIView,saveToDocumentsWithFileName aFilename:String)
    {
        let pdfData = NSMutableData()
        // Creates a mutable data object for updating with binary data, like a byte array
        
        // Points the pdf converter to the mutable data object and to the UIView to be converted
        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
        UIGraphicsBeginPDFPage();
        let pdfContext = UIGraphicsGetCurrentContext();
        
        // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
        
        aView.layer.draw(in: pdfContext!)
        aView.drawHierarchy(in: aView.bounds, afterScreenUpdates: false)
        
        // remove PDF rendering context
        UIGraphicsEndPDFContext();
        
        // Retrieves the document directories from the iOS device
        let documentDirectories = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let documentDirectory = documentDirectories[0] as String
        let documentDirectoryFilename = documentDirectory + "/test.pdf"
        
        // instructs the mutable data object to write its context to a file on disk
        pdfData.write(toFile: documentDirectoryFilename, atomically:true)
        print("documentDirectoryFileName: \(documentDirectoryFilename)")
    }
}

