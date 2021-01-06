//
//  PostModel.swift
//  PCBuildApp
//
//  This File contains struct definitions and functions for ordering
//  fetched reddit api data and organizing it within an easy to use
//  model.
//
//  Created by GusMando on 10/31/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//

import Foundation

//Post struct for holding the decoded data
struct Post: Identifiable
{
    var id: String
    var title: String
    var url: String
}

//Extending post for decoding function and
//and enumeration of fetched data
extension Post: Decodable
{
    enum keys: String, CodingKey
    {
        case id
        case title
        case url
        case data
    }
    
    init(from decoder: Decoder) throws
    {
        //Using keys to decode the reddit information
        let values = try decoder.container(keyedBy: keys.self)
        let dataContainer = try values.nestedContainer(keyedBy: keys.self, forKey: .data)
        
        //Holding post information in struct vars
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        url = try dataContainer.decode(String.self, forKey: .url)
    }
}

//Structure for taking the posts into a list
struct postList
{
    var posts = [Post]()
}

//Extending the list for decoding
extension postList: Decodable
{
    enum keys: String, CodingKey
    {
        case posts = "children"
        case data
    }
    
    //Utlized decoder to build a list of posts
    init(from decoder: Decoder) throws
    {
        //Information taken from the decoded JSON
        let values = try decoder.container(keyedBy: keys.self)
        let data = try values.nestedContainer(keyedBy: keys.self, forKey: .data)
        posts = try data.decode([Post].self, forKey: .posts)
    }
}
