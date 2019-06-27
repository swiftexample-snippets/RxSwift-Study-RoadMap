//
//  TrackDetailsVM.swift
//  RxProject
//
//  Created by nxgdev58 on 26/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class TrackDetailsVM {
    
    

  // var trackDetails : BehaviorRelay<Track> = BehaviorRelay(value: <Track>)
    //var toppingGroups : BehaviorRelay<[ToppingGroup]> = BehaviorRelay(value: [])
//    var trackDetails_ = BehaviorRelay<[Track]>(value: <Track>)

//    let trackDetails_ = BehaviorRelay<Track>.self

    
    // In Behaviour need to take value after subscribe
    var trackDetails = BehaviorRelay<Track?>(value: nil)

    
    

        
    
    

    
}
