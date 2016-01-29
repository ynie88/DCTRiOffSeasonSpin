//
//  TimerCollectionController.swift
//  DCTriOffSeasonSpin
//
//  Created by Yuchen Nie on 12/14/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation
import UIKit

let timerClassReuseID = "timerClassReuseID"
let kNotificationIdentifierForward = "kNotificationIdentifierForward"
class TimerCollectionController:UICollectionViewController {
    var currentIndex = 0
    
    override func viewDidLoad() {
        collectionView?.userInteractionEnabled = false
        collectionView?.registerClass(TimerCollectionCells.self, forCellWithReuseIdentifier: timerClassReuseID)
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.scrollEnabled = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shiftOne", name: kNotificationIdentifierForward, object: nil)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        
        self.collectionView?.collectionViewLayout = layout
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        super.viewDidLoad()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(timerClassReuseID, forIndexPath: indexPath) as! TimerCollectionCells
        cell.configureLabels(WorkoutSet.sharedInstance.playlist[indexPath.row])
        if indexPath.row < WorkoutSet.sharedInstance.playlist.count - 1{
            let set = WorkoutSet.sharedInstance.playlist[indexPath.row + 1]
            let text = "Coming up: " + set.heartRate + " " + set.cadence + " " + set.strDuration
            cell.configureNextSet(text)
        } else {
            let text = "Take it easy, you've earned it!"
            cell.configureNextSet(text)
        }
        cell.startTimer()
        if indexPath.row % 3 == 0{
            cell.contentView.backgroundColor = UIColor.blackColor()
        } else if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.redColor()
        } else if indexPath.row % 3 == 0 {
            cell.contentView.backgroundColor = UIColor.yellowColor()
        } else if indexPath.row % 5 == 0 {
            cell.contentView.backgroundColor = UIColor.purpleColor()
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentIndex++
        self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forRow: currentIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WorkoutSet.sharedInstance.playlist.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
    }
    
    func shiftOne() {
        currentIndex++
        if currentIndex < collectionView?.numberOfItemsInSection(0){
            self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forRow: currentIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        }
    }
    
}