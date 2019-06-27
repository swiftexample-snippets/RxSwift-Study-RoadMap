//
//  Service.swift
//  RxProject
//
//  Created by nxgdev58 on 13/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



typealias Walkin = [WalkinElement]



struct WalkinElement: Codable {

    let category: String?
    let service: [Service]?
}

// MARK: - Service
struct Service: Codable {
    let serviceName, code: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceName
        case code
    }
        
}

extension Walkin {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Walkin.self, from: data)
            print("me",me)
            self = me
        }
        catch {
            print(error)
            return nil
        }
    }
}
