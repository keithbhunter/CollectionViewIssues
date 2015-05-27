//
//  ViewController.swift
//  CollectionViewIssues
//
//  Created by Keith Hunter on 5/26/15.
//  Copyright (c) 2015 Keith Hunter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, VOLBarSliderCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var edit: Bool = false
    var percentages: [Int] = [50, 50, 50, 50, 50, 50, 50, 50, 50, 50]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.registerNib(VOLBarSliderCell.nib(), forCellWithReuseIdentifier: VOLBarSliderCell.reuseIdentifier())
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    
    // MARK: - Actions

    @IBAction func editPressed(sender: UIBarButtonItem) {
        self.edit = !self.edit
        self.collectionView.reloadData()
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(VOLBarSliderCell.reuseIdentifier(), forIndexPath: indexPath) as! VOLBarSliderCell
        cell.tintColor = self.collectionView.superview!.tintColor
        cell.barSlider.value = CGFloat(self.percentages[indexPath.row])
        cell.delegate = self
        cell.editing = self.edit
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(50.0, self.collectionView.bounds.size.height)
    }
    
    
    // MARK: - VOLBarSliderCellDelegate
    
    func barSliderCellValueDidChange(cell: VOLBarSliderCell) {
        if let indexPath = self.collectionView.indexPathForCell(cell) {
            self.percentages[indexPath.row] = Int(cell.barSlider.value)
        }
    }
    
    func barSliderCellTappedInEditMode(cell: VOLBarSliderCell) {
        // don't need this right now
    }
    
}

