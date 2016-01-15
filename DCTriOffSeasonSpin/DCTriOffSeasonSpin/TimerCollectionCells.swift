//
//  TimerCollectionCells.swift
//  DCTriOffSeasonSpin
//
//  Created by Yuchen Nie on 12/14/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation
import SnapKit
import MBCircularProgressBar

class TimerCollectionCells: UICollectionViewCell {
    static let fontSize:CGFloat = 28.0
    private var standardFont:UIFont {
        get {
            return UIFont(name: "HelveticaNeue-Light", size: TimerCollectionCells.fontSize)!
        }
    }
    
    private var largeFont:UIFont {
        get {
            return UIFont(name: "HelveticaNeue-Medium", size: TimerCollectionCells.fontSize)!
        }
    }
    
    private var largeFontThin:UIFont {
        get {
            return UIFont(name: "HelveticaNeue-UltraLight", size: TimerCollectionCells.fontSize)!
        }
    }
    
    static let identifier = "TimerCollectionCells"
    
    var timer = NSTimer() //make a timer variable, but do do anything yet
    let timeInterval:NSTimeInterval = 00.05
    let timerEnd:NSTimeInterval = 0.0
    var timeCount:NSTimeInterval = 0.0
    
    private lazy var minutesLabel:UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = self.standardFont
        _label.textColor        = UIColor.whiteColor()
        self.contentView.addSubview(_label)
        return _label
    }()
    private lazy var secondsLabel: UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = self.standardFont
        _label.textColor       = UIColor.whiteColor()
        self.contentView.addSubview(_label)
        return _label
    }()
    private lazy var microSecondsLabel: UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = self.standardFont
        _label.textColor       = UIColor.whiteColor()
        self.contentView.addSubview(_label)
        return _label
    }()
    
    private lazy var doneLabel: UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = UIFont(name: "HelveticaNeue-UltraLight", size: 35.0)
        _label.text             = "ALL DONE!"
        _label.textColor        = UIColor.whiteColor()
        _label.textAlignment    = .Center
        self.contentView.addSubview(_label)
        return _label
    }()
    
    private lazy var timeRemainingLabel: UILabel = {
       let label = UILabel(frame: .zero)
        label.font = self.standardFont
        label.text = "Time remaining"
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var cadenceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.standardFont
        label.text = "Cadence Label Cadence Label Cadence Label Cadence Label Cadence Label"
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var heartRateZoneLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.largeFont
        label.text = "Heart Rate Zone Heart Rate Zone Heart Rate Zone Heart Rate Zone Heart Rate Zone"
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var notes: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.largeFontThin
        label.text = "notes label"
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var progressView:MBCircularProgressBarView = {
       let progressView = MBCircularProgressBarView(frame: .zero)
        progressView.progressAngle = 75
        progressView.progressLineWidth = 15
        progressView.progressColor = UIColor.whiteColor()
        progressView.progressStrokeColor = UIColor.whiteColor()
        progressView.backgroundColor = UIColor.clearColor()
        progressView.fontColor = UIColor.whiteColor()
        progressView.unitString = "%"
        
        self.contentView.addSubview(progressView)
        return progressView
    }()
    
    override func updateConstraints() {
        secondsLabel.snp_updateConstraints { (make) -> Void in
            make.center.equalTo(self.contentView)
        }
        minutesLabel.snp_updateConstraints { (make) -> Void in
            make.centerY.equalTo(secondsLabel)
            make.right.equalTo(secondsLabel.snp_left).offset(-1.0)
        }
        microSecondsLabel.snp_updateConstraints { (make) -> Void in
            make.centerY.equalTo(secondsLabel)
            make.left.equalTo(secondsLabel.snp_right).offset(1.0)
        }
        timeRemainingLabel.snp_updateConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(secondsLabel.snp_top).offset(-5)
        }
        heartRateZoneLabel.snp_updateConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(15)
        }
        cadenceLabel.snp_updateConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(heartRateZoneLabel.snp_bottom).offset(5)
        }
        progressView.snp_updateConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-5)
            make.width.equalTo(200)
            make.height.equalTo(self.progressView.snp_width)
        }
        
        super.updateConstraints()
    }
    
    var maxValue:CGFloat = 0
    
    func configureLabels(workoutSet:Set) {
        timeCount = workoutSet.duration
        cadenceLabel.text = workoutSet.cadence
        heartRateZoneLabel.text = workoutSet.heartRate
    }
    
    func startTimer() {
        contentView.backgroundColor = UIColor.blueColor()
        if !timer.valid{ //prevent more than one timer on the thread
            progressView.maxValue = 100
            maxValue = CGFloat(timeCount)
            progressView.value = 0
            setTimerLabels()
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
                target: self,
                selector: "timerDidEnd:",
                userInfo: "Timer Done!!",
                repeats: true) //repeating timer in the second iteration
        }
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    func resetTimer() {
        timer = NSTimer()
        setTimerLabels()
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
            target: self,
            selector: "timerDidEnd:",
            userInfo: "Timer Done!!",
            repeats: true) //repeating timer in the second iteration
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func timerDidEnd(timer:NSTimer){
        timeCount = timeCount - timeInterval
        if timeCount <= 0 {  //test for target time reached.
            //addDoneLabel()
            NSNotificationCenter.defaultCenter().postNotificationName(kNotificationIdentifierForward, object: nil)
            timer.invalidate()
        } else { //update the time on the clock if not reached
            setTimerLabels()
            progressView.value = (CGFloat(timeCount)/maxValue)*100
        }
    }
    
    func setTimerLabels() {
        let (minute, seconds, fractionSecond) = HelperFunctions.timeString(timeCount)
        minutesLabel.text = minute
        secondsLabel.text = seconds
        microSecondsLabel.text = fractionSecond
    }
    
    func addDoneLabel() {
        minutesLabel.hidden = true
        secondsLabel.hidden = true
        microSecondsLabel.hidden = true
        
        doneLabel.snp_updateConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
}
