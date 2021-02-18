//
//  EventDetailViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/15.
//

import UIKit


// UICollectionView 縦幅

class EventDetailViewController: UIViewController{
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var eventDetailCollectionView: UICollectionView!{
        didSet {
            eventDetailCollectionView.delegate = self
            eventDetailCollectionView.dataSource = self
            eventDetailCollectionView.register(UINib(nibName: "TimeZoneCell", bundle: nil), forCellWithReuseIdentifier: "timeZoneCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = BidirectionalCollectionLayout()
        layout.delegate = self
        eventDetailCollectionView.collectionViewLayout = layout
        eventDetailCollectionView.reloadData()
        
    }
}

extension EventDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
}


extension EventDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeZoneCell", for: indexPath) as! TimeZoneCell
        
        DispatchQueue.main.async {
            cell.backgroundColor = .blue
            cell.layer.cornerRadius = 5
        }
        
        return cell
    }
}

extension EventDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 40)
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        print("呼ばれた")
//        return CGFloat(10)
//    }
}
