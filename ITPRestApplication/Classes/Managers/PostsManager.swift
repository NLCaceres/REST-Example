//
//  PostsManager.swift
//  ITPRestApplication
//
//  Created by Demo on 1/28/16.
//

import Foundation

class PostsManager : ManagerBase {
    
    
    class func readPostsWithHandler(_ callback:@escaping (_ posts : Array<Post>?, _ error: AnyObject?)->()){
        ServerAPIManager.sharedInstance.readResource(ServerAPIManager.Resources.Posts) {
            (data, error) -> () in
            
            if error != nil{
                
               callback(nil, error)
            
            }else{
                var posts : Array<Post>? = [Post]()
                guard let data = data as? Data else {
                    print("Data issue")
                    return
                }
                posts = try? JSONDecoder().decode([Post].self, from: data)
                //print("This is the data: \(String(decoding: data, as: UTF8.self))")
                
                callback(posts, nil)
            }
        }
    }
    
    
    class func createPost(_ post : Post, withHandler callback: @escaping (_ success : Bool, _ error: AnyObject?) -> Void){
        
        let postData = post.toDictionary(withRootNode: "message")
        
        // create the resource
        ServerAPIManager.sharedInstance.createResource(ServerAPIManager.Resources.Posts, data: postData) {
            (data, error) -> () in
            
            if error != nil{
                callback(false, error)
            }
            else {
                callback(true, nil)
            }
        }
    }
}
