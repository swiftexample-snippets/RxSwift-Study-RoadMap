//
//  TracksViewController.swift
//  RxProject
//
//  Created by nxgdev58 on 10/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TracksViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableViewTracks: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let trackVM = TracksViewModel()
    
    let disposebag = DisposeBag()
    
     let activityIndicator = UIActivityIndicatorView()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
        trackVM.loadData()
    }
    
    func setupBindings(){
        
        trackVM.loading
                .bind(to: self.rx.isAnimating)
                .disposed(by: disposebag)

        
        
        
        trackVM.setupSearch(text: searchBar.rx.text)
       
        tableViewTracks.register(UINib(nibName: "TracksTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: TracksTableViewCell.self))
        
        trackVM.onTracksUpdate
            .observeOn(MainScheduler.instance)
            .bind(to: tableViewTracks.rx.items(cellIdentifier: "TracksTableViewCell", cellType: TracksTableViewCell.self)){  (row,track,cell) in
                cell.cellTrack = track
            }
            .disposed(by: disposebag)
        
        tableViewTracks.rx.modelSelected(Track.self)
            .subscribe(onNext: { value in
                 let tracksDetVC = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as? TrackDetailViewController
                tracksDetVC?.detVM.trackDetails.accept(value)
                self.navigationController?.pushViewController(tracksDetVC!, animated: true)
                
            })
        .disposed(by: disposebag)
        
        
//        tableViewTracks.rx.modelDeselected(Track.self)
//            .subscribe({ value in
//                tableViewTracks.deselectRow(at: indexpath , animated: true)
//            })
//            .disposed(by: disposebag)
        
//        tableViewTracks.refreshControl?.rx.controlEvent(.valueChanged)
//            .subscribe(onNext: { [weak self] in
//                self?.trackVM.loadData()
//            })
//            .disposed(by: disposebag)
        
      
        
  
        
        
        
    }
    
    
    
 
    
    
    
    
    
}

