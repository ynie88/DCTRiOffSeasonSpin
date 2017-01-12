//
//  TimerCollectionController.swift
//  DCTriOffSeasonSpin
//
//  Created by Yuchen Nie on 12/14/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation
import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


let timerClassReuseID = "timerClassReuseID"
let kNotificationIdentifierForward = "kNotificationIdentifierForward"
class TimerCollectionController:UICollectionViewController {
    var currentIndex = 0
    
    override func viewDidLoad() {
        collectionView?.isUserInteractionEnabled = false
        collectionView?.register(TimerCollectionCells.self, forCellWithReuseIdentifier: timerClassReuseID)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.isScrollEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(TimerCollectionController.shiftOne), name: NSNotification.Name(rawValue: kNotificationIdentifierForward), object: nil)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.collectionView?.collectionViewLayout = layout
        
        UIApplication.shared.isStatusBarHidden = true
        
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timerClassReuseID, for: indexPath) as! TimerCollectionCells
        cell.configureLabels(WorkoutSet.sharedInstance.playlist[(indexPath as NSIndexPath).row])
        if (indexPath as NSIndexPath).row < WorkoutSet.sharedInstance.playlist.count - 1{
            let set = WorkoutSet.sharedInstance.playlist[(indexPath as NSIndexPath).row + 1]
            let text = "Coming up: \n" + set.heartRate + " \n" + set.cadence + " \nDuration: \(set.strDuration)"
            cell.configureNextSet(text)
        } else {
            let text = "Take it easy, you've earned it!"
            cell.configureNextSet(text)
        }
        cell.startTimer()
        if (indexPath as NSIndexPath).row % 3 == 0{
            cell.contentView.backgroundColor = UIColor.black
        } else if (indexPath as NSIndexPath).row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.red
        } else if (indexPath as NSIndexPath).row % 3 == 0 {
            cell.contentView.backgroundColor = UIColor.yellow
        } else if (indexPath as NSIndexPath).row % 5 == 0 {
            cell.contentView.backgroundColor = UIColor.purple
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex += 1
        self.collectionView?.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WorkoutSet.sharedInstance.playlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    func shiftOne() {
        currentIndex += 1
        if currentIndex < collectionView?.numberOfItems(inSection: 0){
            self.collectionView?.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
}
