//
//  TracksTableViewCell.swift
//  RxProject
//
//  Created by nxgdev58 on 10/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import UIKit
import RxSwift


struct itemS {
    
    var title : String?
    var aritist : String?
    var previewURL: String?
    
}

class audioButton:UIButton{

    var isToggle: Bool = false {
        didSet {
            if isToggle {
                print("play")
            } else {
                print("pause")

            }
        }
}
}



class TracksTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTrack: UIImageView!
    @IBOutlet weak var labelTrackTitle: UILabel!
    @IBOutlet weak var buttonPlay: audioButton!
    let player = RxPlayer()
    let disposebag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    public var cellTrack : Track?{
        didSet{
            imageTrack.loadImage(fromURL: cellTrack?.artworkUrl100 ?? "")
            labelTrackTitle.text = cellTrack?.trackName ?? ""
            buttonPlay.rx.tap
                .subscribe({_ in
                    
                    let url = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview118/v4/9d/45/8a/9d458a3b-b7b4-889f-8d26-c1fc89be94ad/mzaf_7235570234125559013.plus.aac.p.m4a")
                    let playItem = RxPlayerItem(title: "", artist: "", url: url)
                    
                    
                    self.player.playItem(playItem)
                })
                
                
                .disposed(by: disposebag)
            
        }
    }
    
    override func prepareForReuse() {
        imageTrack.image = UIImage()
    }
  
 
    
}




