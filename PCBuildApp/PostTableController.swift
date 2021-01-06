//
//  PostTableController.swift
//  PCBuildApp
//
//  This class will act as the controller for the deal/post list displaying
//  Information fetched utilizing the reddit api and displaying it to the user.
//
//  Created by GusMando on 10/31/20.
//  Copyright © 2020 Agustin Gomez. All rights reserved.
//

import Foundation;
import UIKit;

class PostTableController: UIViewController, UITableViewDelegate,UITableViewDataSource
{
    //Variables used for changing title and part type
    //related information
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var postTable: UITableView!
    var top:String?
    var partType:String?
    var done = false
    var list:postList?
    
    override func viewDidLoad()
    {
        //Checking if a url has been passed in
        if let url = URL(string: partType!)
        {
           //Creating a url session to fetch api information with
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data
              {
                  do
                  {
                    //Grabbign the JSON information and decoding into a list
                    let res = try JSONDecoder().decode(postList.self, from: data)
                    self.list = res
                    //Reloading the data for the post table
                    DispatchQueue.main.async {
                       self.postTable.reloadData()
                    }
                    print(self.list!.posts.count)
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
        
        //Changing navigation bar title
        navBar.title = top!
        
        super.viewDidLoad()
        
    }

    //Utlizing the count of posts to build table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(list != nil)
        {
            return list!.posts.count
        }
        else
        {
            return 0
        }
    }
    
    //Building a cell for each row using the information from the api now in a list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableCell
        if(list != nil)
        {
            let link = list!.posts[indexPath.row]
            cell.titleText.text = link.title
            cell.urlText.text = link.url
        }
        return cell
    }
    
    //React to pressing any of the cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //Opening the url and showing the deal post
        UIApplication.shared.openURL(URL(string: list!.posts[indexPath.row].url)!)
    }

    
}
