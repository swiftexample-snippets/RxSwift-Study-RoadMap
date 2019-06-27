//
//  HomeCollectionViewController.swift
//  RxProject
//
//  Created by nxgdev58 on 26/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import UIKit
import Foundation

class HomeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
    @IBOutlet weak var detailsList: UICollectionView!
    @IBOutlet weak var Locationlist: UICollectionView!
    let locations = ["haihaihaihaihaihaihai", "hellohellohellohellohello", "hellohellohellohellohello","allllllallllllallllllallllllallllll", "bbbb","hai", "hello", "how","allllll", "bbbb"]
    
    
    
    var locationsDetails = ["hai", "hello", "how","allllll", "bbbb","hai", "hello", "how","allllll", "bbbb"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // locationsList.dataSource = mainModel.dataSource!;
        Locationlist.reloadData();
        
        Locationlist.delegate = self;
        Locationlist.dataSource = self;
        
        detailsList.delegate = self;
        detailsList.dataSource = self;
        
        
        
        
        
        
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Locationlist{
            return locations.count;

        }else{
            return locationsDetails.count;

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == Locationlist{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath) as! CategoriesCollectionViewCell;
            
            let location = locations[indexPath.row];
            cell.locationName = location;
            
            return cell;

            
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailCollectionViewCell;
            
            let location = locations[indexPath.row];
            cell.locationName = location;
            
            return cell;

            
        }

    

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("Deselected")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("shfgdsfgidks")
        locationsDetails = ["hai", "hello", "how"]
        detailsList.reloadData()
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
