//
//  EventDetailViewController.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/15.
//

import UIKit
import RxSwift

class EventDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var startInputButton: UIButton! {
        didSet {
            startInputButton.cornerRadius = 10
        }
    }
    @IBOutlet weak var eventDetailCollectionView: UICollectionView! {
        didSet {
            eventDetailCollectionView.delegate = self
            eventDetailCollectionView.dataSource = self
            eventDetailCollectionView.register(UINib(nibName: "TimeZoneCell", bundle: nil), forCellWithReuseIdentifier: "timeZoneCell")
        }
    }
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = BidirectionalCollectionLayout()
        layout.delegate = self
        eventDetailCollectionView.collectionViewLayout = layout
        eventDetailCollectionView.reloadData()
        
        startInputButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController(InputScheduleViewController(jsonString: nil), animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension EventDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
}

extension EventDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
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
        return CGSize(width: 40, height: 30)
    }
}
