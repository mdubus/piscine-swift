//
//  APIModel.swift
//  rush00
//
//  Created by Morgane DUBUS on 3/30/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation

struct TokenAPI: Codable {
    var access_token: String?
}

struct Author: Codable {
    let login: String
}



struct Topic: Codable {
    let id: Int
    let name: String
    let created_at: String
    let author: Author
    let message: TopicMessage
}

struct TopicMessage: Codable{
    let content: TopicMessageContent
    
}

struct TopicMessageContent: Codable{
    let markdown : String
}

struct Message: Codable {
    let id: Int
    let author: Author
    let content: String
    let created_at: String
    let replies: [Message]
}

/****** TOPIC UPDATE ******/
struct TopicUpdate: Codable{
    let topic: TopicUpdateCompo
}

struct TopicUpdateCompo: Codable{
    let name: String
    let message_attributes: TopicMessageAt
    //let message: APIMessageAttr
}

struct TopicMessageAt: Codable{
    let content: String
}


/* *************** TOPICS *************** */

struct APIMessageAttr:Codable {
    let content: String
    let messageable_id:String
    let messageable_type:String
}

struct NewTopic: Codable {
    let cursus_ids: [String]
    let kind: String
    let language_id:String
    let messages_attributes: [APIMessageAttr]
    let name:String
    let tag_ids: [String]
    
}

struct AddTopic:Codable {
    let topic: NewTopic
}


/* *************** TOKEN INFOS *************** */

struct tokenInfos:Codable {
    let resource_owner_id: Int
}









