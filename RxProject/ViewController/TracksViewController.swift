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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
        trackVM.loadData()
    }
    
    func setupBindings(){
        
        
        trackVM.setupSearch(text: searchBar.rx.text)
        tableViewTracks.register(UINib(nibName: "TracksTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: TracksTableViewCell.self))
        trackVM.onTracksUpdate
            .observeOn(MainScheduler.instance)
            .bind(to: tableViewTracks.rx.items(cellIdentifier: "TracksTableViewCell", cellType: TracksTableViewCell.self)){  (row,track,cell) in
                cell.cellTrack = track
            }
            .disposed(by: disposebag)
        
    
        
        
    }
    
    
    
 
    
    
    
    
    
}

