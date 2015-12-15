//
//  TimerCollectionCells.swift
//  DCTriOffSeasonSpin
//
//  Created by Yuchen Nie on 12/14/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation
import SnapKit

class TimerCollectionCells: UICollectionViewCell {
    lazy var backgroundColorView:UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.getRandomColor()
        self.addSubview(backgroundView)
        return backgroundView
    }()
    
    lazy var timerLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(23)
        label.numberOfLines = 1
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        backgroundColorView.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        timerLabel.snp_updateConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        
        super.updateConstraints()
    }
    
    
    var timer = NSTimer() //make a timer variable, but do do anything yet
    let timeInterval:NSTimeInterval = 0.05
    let timerEnd:NSTimeInterval = 0.0
    var timeCount:NSTimeInterval = 10.0
    //MARK: - Actions
    
    func startTimer() {
        
        if !timer.valid{ //prevent more than one timer on the thread
            timerLabel.text = timeString(timeCount)
            print(timerLabel.text!)
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
                target: self,
                selector: "timerDidEnd:",
                userInfo: "Pizza Done!!",
                repeats: true) //repeating timer in the second iteration
        }
    }

    func stopTimer() {
        //timerLabel.text = "Timer Stopped"
        timer.invalidate()
    }

    
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        //let seconds = Int(time) % 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10.0))
    }
    
    func timerDidEnd(timer:NSTimer){
        //timerLabel.text = timer.userInfo as? String
        
        if true{
            //timer that counts down
            timeCount = timeCount - timeInterval
            if timeCount <= 0 {  //test for target time reached.
                timerLabel.text = "Pizza Ready!!"
                timer.invalidate()
            } else { //update the time on the clock if not reached
                timerLabel.text = timeString(timeCount)
                print(timerLabel.text)
            }
            
        } else {
            //timer that counts up
            timeCount = timeCount + timeInterval
            if timeCount >= timerEnd{  //test for target time reached.
                timerLabel.text = "Pizza Ready!!"
                timer.invalidate()
            } else { //update the time on the clock if not reached
                timerLabel.text = timeString(timeCount)
            }
            
        }
        
    }
}

extension UIColor {
    static func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}
