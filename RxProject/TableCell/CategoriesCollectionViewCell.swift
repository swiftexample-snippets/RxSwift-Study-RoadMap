//
//  CategoriesCollectionViewCell.swift
//  RxProject
//
//  Created by nxgdev58 on 26/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var locationNameLabel: UILabel!;
    
    static let locationNameFont:UIFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin);
    
    var locationName: String
    {
        didSet
        {
            locationNameLabel.text = locationName;
        }
    }
    
    override var isSelected: Bool
        {
        didSet
        {
           // locationNameLabel.textColor = isSelected ? UIColor.yellow : UIColor.white;
        }
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        self.locationName = "";
        super.init(coder: aDecoder);
    }

    
}
