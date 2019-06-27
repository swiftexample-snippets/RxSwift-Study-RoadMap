//
//  Track.swift
//  RxProject
//
//  Created by nxgdev58 on 10/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift



//struct Track:Codable {
//    let resultCount: Int?
//    let results: [Result]?
//}
// MARK: - Result

struct Track: Codable {
    let wrapperType: WrapperType?
    let kind: Kind?
    var trackID = Int()
    var trackName = String()
    let artistID, collectionID: Int?
    let artistName: ArtistName?
    let collectionName, collectionCensoredName, trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    var artworkUrl100: String?
    let artworkUrl30, artworkUrl60 : String?
    let collectionPrice, trackPrice: Double?
    let collectionExplicitness, trackExplicitness: Explicitness?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: Country?
    let currency: Currency?
    let primaryGenreName: PrimaryGenreName?
    let isStreamable: Bool?
    let collectionArtistName: String?
    let collectionArtistID: Int?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, collectionArtistName
        case collectionArtistID = "collectionArtistId"
    }
    
    
    var artworkUrl800:String?{
        
         return artworkUrl100?.replacingOccurrences(of: "100", with: "800")
        
    }
   
    
    static func allTracks() -> Observable<[Track]>{

        return Observable.create { (observer) -> Disposable in
            APIManager.requestData(url: "https://itunes.apple.com/search?term=jack+johnson", method: .get, parameters: nil) { (result) in
                switch result{
                case .success(let returnJson):
                    let tracks = returnJson["results"].array!.compactMap {return Track(data: try! $0.rawData())}
                    observer.onNext(tracks.sorted(by: { $0.trackName < $1.trackName }))
                    observer.onCompleted()
                case .failure(let failure):
                    observer.onError(failure)
                }
            }
            return Disposables.create()
        }
        
    }
    
 
}

enum ArtistName: String, Codable {
    case jackJohnson = "Jack Johnson"
    case jackJohnsonDaveMatthewsTimReynolds = "Jack Johnson, Dave Matthews & Tim Reynolds"
}

enum Explicitness: String, Codable {
    case explicit = "explicit"
    case notExplicit = "notExplicit"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case song = "song"
}

enum PrimaryGenreName: String, Codable {
    case alternative = "Alternative"
    case rock = "Rock"
}

enum WrapperType: String, Codable {
    case track = "track"
}

extension Track {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Track.self, from: data)
            print("me",me)
            self = me
        }
        catch {
            print(error)
            return nil
        }
    }
}

/*struct Result: Codable {
    let trackAlbum, name: String
    let trackArtWork: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case trackAlbum = "track_album"
        case trackArtWork = "track_art_work"
        case id, name
    }
}
extension Result {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Result.self, from: data)
            self = me
        }
        catch {
            print(error)
            return nil
        }
    }
}
*/
