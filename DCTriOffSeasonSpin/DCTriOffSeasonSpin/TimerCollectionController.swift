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

class TimerCollectionController:UICollectionViewController {
    override func viewDidLoad() {
        collectionView?.userInteractionEnabled = false
        collectionView?.registerClass(TimerCollectionCells.self, forCellWithReuseIdentifier: timerClassReuseID)
        collectionView?.backgroundColor = UIColor.whiteColor()
        super.viewDidLoad()
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(timerClassReuseID, forIndexPath: indexPath) as! TimerCollectionCells
        cell.startTimer()
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
    }
    
}