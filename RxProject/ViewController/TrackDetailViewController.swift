//
//  TrackDetailViewController.swift
//  RxProject
//
//  Created by nxgdev58 on 26/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrackDetailViewController: UIViewController {

    
   // var trackDetails : Track? = nil

    @IBOutlet weak var imageViewAlbum: UIImageView!
    
    let detVM = TrackDetailsVM()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Subscribe behaviour relay to get all values
       
        detVM.trackDetails.bind { [unowned self](track) in
            self.imageViewAlbum.loadImage(fromURL: track?.artworkUrl800 ?? "")
        }.disposed(by: disposeBag)

    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
     func prepareForReuse() {
        imageViewAlbum.image = UIImage()
    }
    

}
