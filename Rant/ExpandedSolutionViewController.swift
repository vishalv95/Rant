//
//  ExpandedSolutionViewController.swift
//  Rant
//
//  Created by Alana Layton on 11/26/16.
//  Copyright © 2016 group4. All rights reserved.
//

import UIKit
import ISTimeline

class ExpandedSolutionViewController: UIViewController {

    @IBOutlet var timeline: ISTimeline!
    var solution:Solution? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRectMake(0, 50, 500, 700)
        
        let timeline = ISTimeline(frame: frame)
        timeline.backgroundColor = .whiteColor()
        
        self.view.addSubview(timeline)


        // Do any additional setup after loading the view.
        //populate timeline
        timeline.clipsToBounds = false
        let black = UIColor.blackColor()
        
        let touchAction = { (point:ISPoint) in
            print("point \(point.title)")
        }
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle

        let timelineEvents = solution!.mutableSetValueForKey("timeline")
        
        var timelineEventsArray:[Timeline] = Array(timelineEvents) as! [Timeline]
        timelineEventsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
        var myPoints:[ISPoint] = []
        

        
        for timelineEvent in timelineEventsArray {
            let time = dateformatter.stringFromDate(timelineEvent.ts!)
            myPoints.append(ISPoint(title: time, description: timelineEvent.body!, pointColor: black, lineColor: black,touchUpInside: touchAction, fill: false))
            print(timelineEvent.body!)
        }

        
        timeline.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
        timeline.points = myPoints


    }
    
    override func viewWillAppear(animated: Bool) {
        let frame = CGRectMake(0, 50, 500, 700)
        
        let timeline = ISTimeline(frame: frame)
        timeline.backgroundColor = .whiteColor()
        
        self.view.addSubview(timeline)
        
        
        // Do any additional setup after loading the view.
        //populate timeline
        timeline.clipsToBounds = false
        let black = UIColor.blackColor()
        
        let touchAction = { (point:ISPoint) in
            print("point \(point.title)")
        }
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        let timelineEvents = solution!.mutableSetValueForKey("timeline")
        
        var timelineEventsArray:[Timeline] = Array(timelineEvents) as! [Timeline]
        timelineEventsArray.sortInPlace({$0.ts!.compare($1.ts!) == NSComparisonResult.OrderedAscending })
        var myPoints:[ISPoint] = []
        
        
        
        for timelineEvent in timelineEventsArray {
            let time = dateformatter.stringFromDate(timelineEvent.ts!)
            myPoints.append(ISPoint(title: time, description: timelineEvent.body!, pointColor: black, lineColor: black,touchUpInside: touchAction, fill: false))
            print(timelineEvent.body!)
        }
        
        
        timeline.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
        timeline.points = myPoints
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addPoint(title: String, description: String) {
        let point = ISPoint(title: title)
        point.description = description
        point.lineColor = .redColor()
        point.fill = true
        timeline.points.append(point)
    }

    @IBAction func addSolutionEvent(sender: AnyObject) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTimelineEventSegue",
            let atvc = segue.destinationViewController as? AddTimelineEventViewController{
                atvc.solution = solution
        }

    }


}
