//
//  UrlRequests.swift
//  GetDataPixabay
//
//  Created by Yerassyl Orazbekov on 30.11.2021.
//

import UIKit

struct ImageStruct: Decodable {
    var id: Int
    var pageURL: String
    var type: String
    var tags: String
    var previewURL: String
    var previewWidth: Int
    var previewHeight: Int
    
    var webformatURL: String
    var webformatWidth: Int
    var webformatHeight: Int
    var largeImageURL: String

    var imageWidth: Int
    var imageHeight: Int
    var imageSize: Int
    var views: Int
    var downloads: Int
    var collections: Int
    var likes: Int
    var comments: Int
    var user_id: Int
    var user: String
    var userImageURL: String
}

struct GetImagesStruct: Decodable {
    var total: Int
    var totalHits: Int
    var hits: [ImageStruct]
}

struct VideosSize: Decodable {
    var url: String
    var width: Int
    var height: Int
    var size: Int
}

struct VideoQuailty: Decodable {
    var large: VideosSize
    var small: VideosSize
    var medium: VideosSize
    var tiny: VideosSize
}

struct VideoStruct: Decodable {
    var id: Int
    var pageURL: String
    var type: String
    var tags: String
    var duration: Int
    var picture_id: String
    var videos: VideoQuailty
    var views: Int
    var downloads: Int
    var likes: Int
    var comments: Int
    var user_id: Int
    var user: String
    var userImageURL: String
}
//"views":86742,
//            "downloads":47335,
//            "likes":456,
//            "comments":156,
//            "user_id":4994132,
//            "user":"adege",
//            "userImageURL":"https://cdn.pixabay.com/user/2019/11/12/18-53-20-554_250x250.jpg"

struct GetVideosStruct: Decodable {
    var total: Int
    var totalHits: Int
    var hits: [VideoStruct]
}
//"total":187,
//"totalHits":187,
//"hits":[
//    {
//        "id":22634,
//        "pageURL":"https://pixabay.com/videos/id-22634/",
//        "type":"film",
//        "tags":"buttercups, buttercup, blossom",
//        "duration":26,
//        "picture_id":"773604276-314b5b3d4160acc31aed393475a20dfdf774a00203ad975bef4a42d038b2603e-d",
//        "videos":{
//            "large":{
//                "url":"https://player.vimeo.com/external/328940142.hd.mp4?s=1ea57040d1487a6c9d9ca9ca65763c8972e66bd4&profile_id=172",
//                "width":3840,
//                "height":2120,
//                "size":48810391
//            },
//            "medium":{
//                "url":"https://player.vimeo.com/external/328940142.hd.mp4?s=1ea57040d1487a6c9d9ca9ca65763c8972e66bd4&profile_id=170",
//                "width":2608,
//                "height":1439,
//                "size":21356085
//            },
//            "small":{
//                "url":"https://player.vimeo.com/external/328940142.hd.mp4?s=1ea57040d1487a6c9d9ca9ca65763c8972e66bd4&profile_id=175",
//                "width":1956,
//                "height":1079,
//                "size":12768688
//            },
//            "tiny":{
//                "url":"https://player.vimeo.com/external/328940142.hd.mp4?s=1ea57040d1487a6c9d9ca9ca65763c8972e66bd4&profile_id=174",
//                "width":1304,
//                "height":719,
//                "size":6621423
//            }
//        }

class ApiConverterHelper {
    private let apiKey = "=24606826-c220812e4a17bd8c9c87cad5d"
    private let questions = "&q="
    private let pixabayAPIPhoto = "https://pixabay.com/api/?key"
    private let pixabayAPIVideo = "https://pixabay.com/api/videos/?key"
    private let imageType = "&image_type=photo"

    func getUrlAdress(photoName: String) -> String {
        let photoNameInHttp = stringSpaceToPlus(string: photoName)
        let urlString = pixabayAPIPhoto + apiKey + questions + photoNameInHttp + imageType
        return urlString
    }
    
    func getUrlVideo(photoName: String) -> String {
        let photoNameInHttp = stringSpaceToPlus(string: photoName)
        let urlString = pixabayAPIVideo + apiKey + questions + photoNameInHttp
        return urlString
    }

    func stringSpaceToPlus(string: String) -> String {
        var characters = Array(string)
        let spaceCharacter: Character = " "
        let plusCharacter: Character = "+"
        for index in 0 ..< characters.count {
            if characters[index] == spaceCharacter {
                characters[index] = plusCharacter
            }
        }
        return String(characters)
    }
    
    func creatVideoPictureLink(photoID: String) -> String {
        let imagesSite = "https://i.vimeocdn.com/video/"
        let imageDataType = ".jpg"
        return imagesSite + photoID + imageDataType
    }
}
