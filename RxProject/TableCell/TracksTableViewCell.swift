//
//  TracksTableViewCell.swift
//  RxProject
//
//  Created by nxgdev58 on 10/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import UIKit

class TracksTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTrack: UIImageView!
    @IBOutlet weak var labelTrackTitle: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    public var cellTrack : Track?{
        didSet{
            imageTrack.loadImage(fromURL: cellTrack?.artworkUrl100 ?? "")
            labelTrackTitle.text = cellTrack?.trackName ?? ""
            
        }
    }
    
    override func prepareForReuse() {
        imageTrack.image = UIImage()
    }
  
 
    
}
