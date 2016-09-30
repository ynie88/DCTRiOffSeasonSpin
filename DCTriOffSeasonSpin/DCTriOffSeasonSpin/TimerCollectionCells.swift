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
    fileprivate var standardFont:UIFont {
        get {
            return UIFont(name: "HelveticaNeue-Light", size: TimerCollectionCells.fontSize)!
        }
    }
    
    fileprivate var largeFont:UIFont {
        get {
            return UIFont(name: "HelveticaNeue-Medium", size: TimerCollectionCells.fontSize)!
        }
    }
    
    fileprivate var largeFontThin:UIFont {
        get {
            return UIFont(name: "HelveticaNeue-UltraLight", size: TimerCollectionCells.fontSize)!
        }
    }
    
    static let identifier = "TimerCollectionCells"
    
    var timer = Timer() //make a timer variable, but do do anything yet
    let timeInterval:TimeInterval = 00.05
    let timerEnd:TimeInterval = 0.0
    var timeCount:TimeInterval = 0.0
    
    fileprivate lazy var minutesLabel:UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = self.standardFont
        _label.textColor        = UIColor.white
        self.contentView.addSubview(_label)
        return _label
    }()
    fileprivate lazy var secondsLabel: UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = self.standardFont
        _label.textColor       = UIColor.white
        self.contentView.addSubview(_label)
        return _label
    }()
    fileprivate lazy var microSecondsLabel: UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = self.standardFont
        _label.textColor       = UIColor.white
        self.contentView.addSubview(_label)
        return _label
    }()
    
    fileprivate lazy var doneLabel: UILabel = {
        let _label              = UILabel(frame: .zero)
        _label.font             = UIFont(name: "HelveticaNeue-UltraLight", size: 35.0)
        _label.text             = "ALL DONE!"
        _label.textColor        = UIColor.white
        _label.textAlignment    = .center
        self.contentView.addSubview(_label)
        return _label
    }()
    
    fileprivate lazy var timeRemainingLabel: UILabel = {
       let label = UILabel(frame: .zero)
        label.font = self.standardFont
        label.text = "Time remaining"
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var cadenceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.standardFont
        label.text = "Cadence Label Cadence Label Cadence Label Cadence Label Cadence Label"
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var heartRateZoneLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.largeFont
        label.text = "Heart Rate Zone Heart Rate Zone Heart Rate Zone Heart Rate Zone Heart Rate Zone"
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var notes: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.largeFontThin
        label.text = "notes label"
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var progressView:MBCircularProgressBarView = {
       let progressView = MBCircularProgressBarView(frame: .zero)
        progressView.progressAngle = 75
        progressView.progressLineWidth = 15
        progressView.progressColor = UIColor.white
        progressView.progressStrokeColor = UIColor.white
        progressView.backgroundColor = UIColor.clear
        progressView.fontColor = UIColor.white
        progressView.unitString = "%"
        
        self.contentView.addSubview(progressView)
        return progressView
    }()
    
    fileprivate lazy var nextLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.largeFontThin
        label.text = "Next Label Next Label Next Label Next Label Next Label "
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
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
        nextLabel.snp_updateConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.cadenceLabel.snp_bottom).offset(5)
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
        }
        
        
        super.updateConstraints()
    }
    
    var maxValue:CGFloat = 0
    
    func configureLabels(_ workoutSet:Set) {
        timeCount = workoutSet.duration
        cadenceLabel.text = workoutSet.cadence
        heartRateZoneLabel.text = workoutSet.heartRate
    }
    
    func configureNextSet(_ nextElement:String) {
        nextLabel.text = nextElement
    }
    
    func startTimer() {
        contentView.backgroundColor = UIColor.blue
        if !timer.isValid{ //prevent more than one timer on the thread
            progressView.maxValue = 100
            maxValue = CGFloat(timeCount)
            progressView.value = 0
            setTimerLabels()
            timer = Timer.scheduledTimer(timeInterval: timeInterval,
                target: self,
                selector: #selector(TimerCollectionCells.timerDidEnd(_:)),
                userInfo: "Timer Done!!",
                repeats: true) //repeating timer in the second iteration
        }
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    func resetTimer() {
        timer = Timer()
        setTimerLabels()
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
            target: self,
            selector: #selector(TimerCollectionCells.timerDidEnd(_:)),
            userInfo: "Timer Done!!",
            repeats: true) //repeating timer in the second iteration
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func timerDidEnd(_ timer:Timer){
        timeCount = timeCount - timeInterval
        if timeCount <= 0 {  //test for target time reached.
            //addDoneLabel()
            NotificationCenter.default.post(name: Notification.Name(rawValue: kNotificationIdentifierForward), object: nil)
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
        minutesLabel.isHidden = true
        secondsLabel.isHidden = true
        microSecondsLabel.isHidden = true
        
        doneLabel.snp_updateConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
}
