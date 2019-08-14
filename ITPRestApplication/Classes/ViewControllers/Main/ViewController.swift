//
//  ViewController.swift
//  ITPRestApplication
//
//  Created by Demo on 1/28/16.
//

import UIKit

class ViewController: ViewControllerBase, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var posts : Array<Post>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        releadTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Tableview Related
    func releadTableData(){
        PostsManager.readPostsWithHandler{
            (posts : Array<Post>?, error: AnyObject?) in
            
            self.posts = posts
            
            DispatchQueue.main.async(execute: {
                () -> Void in
                
                print("Reloading the table with new info")
                self.tableView.reloadData()
                
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "postsTableViewCell"
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let post : Post = self.posts[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = post.cName
        cell.detailTextLabel?.text = post.cMessage
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: .editingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.delete) {
//
//            ServerAPIManager.sharedInstance.delete(ServerAPIManager.Resources.Posts) { (data, error) -> () in
//
//                if (error != nil) {
//                    print("Error in deleting this post")
//                }
//                else {
//                    print("Time to delete")
//                    self.posts.remove(at: indexPath.row)
//                    tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation)
//                }
//
//            }
//        }
//    }

}

